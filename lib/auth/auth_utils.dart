import 'dart:async';
import 'dart:io';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:oxen_driver/globals.dart';
import 'package:oxen_driver/models/ModelProvider.dart';

String genericKey = 'oxen_gen_key_8181220';

Future<bool> registerUser(String username) async {
  print('Name: $username, Password: $genericKey');
  bool isSignUpComplete = false;

  Globals.setPhoneNumber(username);

  try {
    Map<String, String> userAttributes = {};

    SignUpResult res = await Amplify.Auth.signUp(
        username: username,
        password: genericKey,
        options: CognitoSignUpOptions(userAttributes: userAttributes));

    isSignUpComplete = res.isSignUpComplete;
  } on UsernameExistsException catch (e) {
    dynamic userModel = await pullUserModel();
    if (userModel != null) {
      print('Account already exists');
    } else {
      isSignUpComplete = true;
    }
  } on AuthException catch (e) {
    print(e.message);
  }

  if (!isSignUpComplete) {
    Globals.setPhoneNumber('');
  }

  return isSignUpComplete;
}

Future<bool> registerDriver(
    String pNum, String fName, String lName, String licenseNum) async {
  try {
    Rider rider = Rider(
        firstName: fName,
        lastName: lName,
        phoneNumber: pNum,
        licenseNumber: licenseNum,
        status: 'f',
        rating: 0,
        ratedBy: 0,
        vehicleId: 'f',
        totalEarned: 0.0,
        totalCommission: 0.0,
        financialData: '{}',
        finishedDeliveries: 0,
        totalConfirmation: false);
    await Amplify.DataStore.save(rider);
  } on DataStoreException catch (e) {
    print(e.message);
    return false;
  }

  return true;
}

Future<bool> registerCompany(
    String pNum, String fName, String lName, String compName) async {
  try {
    Company company = Company(
        firstName: fName,
        lastName: lName,
        companyName: compName,
        phoneNumber: pNum,
        rating: 0,
        ratedBy: 0,
        totalEarned: 0.0,
        totalCommission: 0.0,
        financialData: '{}',
        finishedDeliveries: 0,
        totalConfirmation: false);

    await Amplify.DataStore.save(company);
  } on DataStoreException catch (e) {
    print(e.message);
    return false;
  }

  return true;
}

Future<bool> confirmUserLogin(String code) async {
  bool isSignedIn = false;

  try {
    SignInResult res =
        await Amplify.Auth.confirmSignIn(confirmationValue: code);

    isSignedIn = res.isSignedIn;
    if (isSignedIn) {
      Globals.finalizePrefRole();
      Globals.clearLoginAttempts();
    }
  } on AuthException catch (e) {
    print(e.message);
  }

  return isSignedIn;
}

Future<bool> userSignOut() async {
  try {
    await Amplify.Auth.signOut();

    Globals.setRole('');
    Globals.setPhoneNumber('');
    Globals.setUserModelID('');
    Globals.setSignedInStatus(false);

    Globals.finalizePrefRole();
    await Amplify.DataStore.stop();
    await Amplify.DataStore.clear();
    await Amplify.DataStore.start();
  } on AuthException catch (e) {
    print(e.message);
    return false;
  }
  return true;
}

Future<bool> authUser(String username) async {
  print('Name: $username, Password: $genericKey');

  Globals.incrementLoginAttempts(); //cleared after sign in confirmed
  print('Login Attempts : ' + await Globals.getLoginAttempts());

  try {
    SignInResult res = await Amplify.Auth.signIn(
      username: username,
      password: genericKey,
      options: CognitoSignInOptions(
          clientMetadata: {'loginAttempts': await Globals.getLoginAttempts()}),
    );

    // isSignedIn = res
    //     .isSignedIn; // I think will always be false since MFA enforced. set state()?
    Globals.setPhoneNumber(username);
  } on AuthException catch (e) {
    print(e.message);
    return false;
  }

  return true;
}

Future<bool> checkSession() async {
  bool res = false;

  try {
    AuthUser currentUser = await Amplify.Auth.getCurrentUser();
    AuthSession currentSession = await Amplify.Auth.fetchAuthSession();

    // I don't like setting them here, but I don't want another funcion using auth user and sess
    Globals.setPhoneNumber(currentUser.username);
    Globals.setSignedInStatus(currentSession.isSignedIn);

    print('Current User Details:');
    print(currentUser.toString());
    print(currentUser.userId);
    print(currentUser.username);

    print('Current Session Details:');
    print(currentSession.toString());
    print(currentSession.isSignedIn);

    res = currentSession.isSignedIn;
  }
  // Does not work even if I remove last catch. Prints out whole err log
  // signout on exception?
  on SignedOutException {
    print('Session logging null - no user signed in');
    return res;
  } on NotAuthorizedException {
    print('Session logging null - no user signed in');
    return res;
  } catch (e) {
    print(e);
  }

  return res;
}

Future<dynamic> pullUserModel() async {
  print('Pulling User Model');
  if (Globals.getPhoneNumber() == '') {
    print('No Global Phone Number');
    return null;
  }

  print('Pulling Cloud and Pulling User Model');
  await Globals.pullCloud();

  List<dynamic> userModelList;
  switch (Globals.getRole()) {
    case 'driver':
      print('here');
      userModelList = await Amplify.DataStore.query(Rider.classType,
          where: Rider.PHONENUMBER.eq(Globals.getPhoneNumber()));
      break;
    case 'company':
      userModelList = await Amplify.DataStore.query(Company.classType,
          where: Company.PHONENUMBER.eq(Globals.getPhoneNumber()));
      break;
    default:
      print('Error in roles pref. No user model.');
      userModelList = [];
      break;
  }

  if (userModelList.isNotEmpty) {
    Globals.setUserModelID(userModelList[0].id);
    return userModelList[0];
  }
  return null;
}

Future<void> uploadFiles(List<PlatformFile> toUpload, String identifier) async {
  String fPrefix;
  switch (Globals.getRole()) {
    case 'driver':
      fPrefix = 'DriverRegDocs';
      break;
    case 'company':
      fPrefix = 'CompanyRegDocs';
      break;
    default:
      print(
          'Error uploading files - could not resolve role: ${Globals.getRole()}');
      return;
  }

  toUpload.forEach((e) async {
    try {
      final UploadFileResult result = await Amplify.Storage.uploadFile(
        local: File(e.path.toString()),
        key: '$fPrefix/$identifier/${e.name}',
        options: S3UploadFileOptions(accessLevel: StorageAccessLevel.guest),
      );
      print('Successfully uploaded file: ${result.key}');
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  });
}
