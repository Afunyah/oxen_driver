import 'package:oxen_driver/models/ModelProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Globals {
  static String _role = '';
  static bool _isSignedIn = false;
  static String _phoneNumber = '';

  static List<Rider> riders = [];
  static List<Company> companies = [];

  static void setRider(Rider r) {
    riders.clear();
    companies.clear();
    riders.add(r);
  }

  static void setCompany(Company c) {
    riders.clear();
    companies.clear();
    companies.add(c);
  }

  static Rider getRider() {
    return riders[0];
  }

  static Company getCompany() {
    return companies[0];
  }

  static String getRole() {
    return _role;
  }

  static bool getSignedInStatus() {
    return _isSignedIn;
  }

  static String getPhoneNumber() {
    return _phoneNumber;
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

  static void setSignedInStatus(bool status) {
    _isSignedIn = status;
  }

  static void setPhoneNumber(String pNum) {
    _phoneNumber = pNum;
  }
}
