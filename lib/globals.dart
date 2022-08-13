import 'dart:async';

import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oxen_driver/models/ModelProvider.dart';

class Globals {
  static String _role = '';
  static bool _isSignedIn = false;
  static String _phoneNumber = '';
  static String _userModelID = '';

  static FlutterSecureStorage _secStorage = new FlutterSecureStorage();

  static void setSignedInStatus(bool status) {
    _isSignedIn = status;
  }

  static bool getSignedInStatus() {
    return _isSignedIn;
  }

  static void setPhoneNumber(String pNum) {
    _phoneNumber = pNum;
  }

  static String getPhoneNumber() {
    return _phoneNumber;
  }

  // switch-case require 'constants' use if-else instead and then uncomment
  //  static String companyRole() {
  //   return 'company';
  // }

  // static String driverRole() {
  //   return 'driver';
  // }

  static void incrementLoginAttempts() async {
    await _secStorage.write(
        key: 'sCSatmps',
        value: (int.parse(await getLoginAttempts()) + 1).toString());
  }

  static Future<String> getLoginAttempts() async {
    String? val = await _secStorage.read(key: 'sCSatmps');
    return (val == null) ? '0' : val;
  }

  static void clearLoginAttempts() async {
    await _secStorage.write(key: 'sCSatmps', value: '0');
  }

  static String getRole() {
    return _role.toLowerCase();
  }

  static void setRole(String newRole) async {
    _role = newRole.toLowerCase();
  }

  static Future<void> finalizePrefRole() async {
    await _secStorage.write(key: 'role', value: getRole());
  }

  static Future<void> setRoleFromPref() async {
    String? val = await _secStorage.read(key: 'role');
    _role = (val == null) ? '' : val;
  }

  static String getUserModelID() {
    return _userModelID;
  }

  static void setUserModelID(String newID) {
    _userModelID = newID;
  }

  // static Future<void> pullCloudAndExecute(Function toExec) async {
  //   StreamSubscription dsHub =
  //       Amplify.Hub.listen([HubChannel.DataStore], (hubEvent) {
  //     print("HubEvent is ${hubEvent.eventName}");
  //   });

  //   dsHub.onData((data) async {
  //     print(data.eventName);
  //     if (data.eventName == 'ready') {
  //       print("DataStore READY (custom)");
  //       await toExec();
  //       await dsHub.cancel();
  //     }
  //   });

  //   await Amplify.DataStore.stop();
  //   await Amplify.DataStore.start();
  //   print('Datastore stopped and started - CUSTOM');

  //   await Amplify.DataStore.query(GenericUser.classType).then((value) {
  //     print("Performed Dummy Query");
  //   });

  //   // await Amplify.DataStore.query(GenericUser.classType).then((value) {
  //   //   print("Performed Dummy Query");
  //   // });
  // }

  static Future<void> pullCloud() async {
    await Amplify.DataStore.stop();
    await Amplify.DataStore.start();
    print('Datastore stopped and started - CUSTOM');
    await Amplify.DataStore.query(GenericUser.classType).then((value) {
      print("Performed Dummy Query");
    });
  }
}
