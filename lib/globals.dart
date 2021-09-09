import 'dart:async';

import 'package:amplify_flutter/amplify.dart';
import 'package:oxen_driver/models/ModelProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static String _role = '';
  static bool _isSignedIn = false;
  static String _phoneNumber = '';
  static String _userModelID = '';

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

  static String getRole() {
    return _role.toLowerCase();
  }

  static void setRole(String newRole) async {
    _role = newRole.toLowerCase();
  }

  static Future<void> finalizePrefRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', getRole());
  }

  static Future<void> setRoleFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('role', 'driver'); //just for testing and reset

    _role = prefs.getString('role').toString();
  }

  static String getUserModelID() {
    return _userModelID;
  }

  static void setUserModelID(String newID) {
    _userModelID = newID;
  }

  static void pullCloudAndExecute(Function toExec) async {
    await Amplify.DataStore.query(GenericUser.classType).then((value) {
      print("Performed Dummy Query");
    });

    StreamSubscription dsHub =
        Amplify.Hub.listen([HubChannel.DataStore], (hubEvent) {
      print("HubEvent is ${hubEvent.eventName}");
    });

    dsHub.onData((data) async {
      print(data.eventName);
      if (data.eventName == 'ready') {
        print("DataStore READY (custom)");
        toExec();
        await dsHub.cancel();
      }
    });
  }
}
