import 'dart:async';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:oxen_driver/globals.dart';
import 'package:oxen_driver/models/ModelProvider.dart';

String genericKey = 'oxen_gen_key_8181220';

Future<bool> registerUser(String username) async {
  print('Name: $username, Password: $genericKey');
  bool isSignUpComplete = false;

  try {
    Map<String, String> userAttributes = {};

    SignUpResult res = await Amplify.Auth.signUp(
        username: username,
        password: genericKey,
        options: CognitoSignUpOptions(userAttributes: userAttributes));

    isSignUpComplete = res.isSignUpComplete;
    if (isSignUpComplete) {
      Globals.setPhoneNumber(username);
    }
  } on AuthException catch (e) {
    print(e.message);
  }

  return isSignUpComplete;
}

Future<bool> registerDriver(String username) async {
  try {
    Rider rider = Rider(
        firstName: 'firstName',
        lastName: 'lastName',
        phoneNumber: username,
        status: 'status',
        rating: 5,
        ratedBy: 27,
        vehicleId: 'vehicleId',
        totalEarned: 102.5,
        totalCommission: 87.0,
        financialData: 'financialData',
        finishedDeliveries: 21,
        totalConfirmation: false);
    await Amplify.DataStore.save(rider);
  } on DataStoreException catch (e) {
    print(e.message);
    return false;
  }

  return true;
}

Future<bool> verifyCode(String username, String code) async {
  bool isSignUpComplete = false;
  try {
    SignUpResult res = await Amplify.Auth.confirmSignUp(
        username: username, confirmationCode: code);

    isSignUpComplete = res.isSignUpComplete;
  } on AuthException catch (e) {
    print(e.message);
  }

  return isSignUpComplete;
}

Future<bool> confirmUserLogin(String code) async {
  bool isSignedIn = false;

  try {
    SignInResult res =
        await Amplify.Auth.confirmSignIn(confirmationValue: code);

    isSignedIn = res.isSignedIn;
    if (isSignedIn) {
      Globals.finalizePrefRole();
    }
  } on AuthException catch (e) {
    print(e.message);
  }

  return isSignedIn;
}

Future<bool> userSignOut() async {
  bool isSignedOut = true;
  Globals.setRole('');
  Globals.setPhoneNumber('');
  Globals.setSignedInStatus(false);

  Globals.finalizePrefRole();

  try {
    await Amplify.Auth.signOut();
  } on AuthException catch (e) {
    print(e.message);
  }
  return isSignedOut;
}

Future<bool> authUser(String username) async {
  print('Name: $username, Password: $genericKey');
  bool isSignedIn = false;

  // CognitoAuthSession? session = (await Amplify.Auth.fetchAuthSession(
  //         options: CognitoSessionOptions(getAWSCredentials: true)))
  //     as CognitoAuthSession?;

  // print('Access key: ${session!.credentials!.awsAccessKey}');
  // print('Secret Key: ${session.credentials!.awsSecretKey}');
  // print('Identity ID:  ${session.identityId}');
  // print('User Pool tokens: ${session.userPoolTokens!.accessToken}');
  // print('User Pool tokens: ${session.userPoolTokens!.idToken}');

  try {
    SignInResult res = await Amplify.Auth.signIn(
      username: username,
      password: genericKey,
    );

    isSignedIn = res
        .isSignedIn; // I think will always be false since MFA enforced. set state()?
    Globals.setPhoneNumber(username);
  } on AuthException catch (e) {
    print(e.message);
  }

  return isSignedIn;
}

Future<bool> recoverPassword(String name) async {
  bool isPasswordReset = false;

  try {
    ResetPasswordResult res = await Amplify.Auth.resetPassword(
      username: name,
    );

    isPasswordReset = res.isPasswordReset;
  } on AmplifyException catch (e) {
    print(e);
  }

  return isPasswordReset;
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

Future<Rider?> pullUserModel() async {
  if (Globals.getPhoneNumber() == '') {
    return null;
  }
  List<Rider> riders = await Amplify.DataStore.query(Rider.classType,
      where: Rider.PHONENUMBER.eq(Globals.getPhoneNumber()));

  return riders.isNotEmpty ? riders[0] : null;
}
