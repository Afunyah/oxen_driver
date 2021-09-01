import 'package:oxen_driver/auth/auth_utils.dart';
import 'package:oxen_driver/models/ModelProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static String _role = '';
  static bool _isSignedIn = false;
  static String _phoneNumber = '';

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

  static String getRole() {
    return _role;
  }

  static void setRole(String newRole) async {
    _role = newRole;
  }

  static Future<void> finalizePrefRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', getRole());
  }

  static Future<void> setRoleFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('role', 'driver'); //just for testing

    _role = prefs.getString('role').toString();
  }
}
