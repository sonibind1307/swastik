import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static final _sharedInstance = Auth._internal();

  Auth._internal();

  static Auth getInstance() {
    return _sharedInstance;
  }

  static final _instance = SharedPreferences.getInstance();

  static final String user_id = "USERID";
  static final String user_name = "USERNAME";
  static final String mobile_number = "MOBILE";
  static final String full_name = "FULLNAME";
  static final String email = "EMAIL";
  static final String designation = "DESIGNATION";
  static final String fcm_token = "FCMTOKEN";

  static Future<void> setUserID(String userName) async {
    final prefs = await _instance;
    prefs.setString(user_id, userName);
  }

  static Future<String?> getUserID() async {
    final prefs = await _instance;
    return prefs.getString(user_id) ?? "";
  }

  static Future<void> setDesignation(String userName) async {
    final prefs = await _instance;
    prefs.setString(designation, userName);
  }

  static Future<String?> getDesignation() async {
    final prefs = await _instance;
    return prefs.getString(designation) ?? "";
  }

  static Future<void> setName(String value) async {
    final prefs = await _instance;
    prefs.setString(full_name, value);
  }

  static Future<String?> getName() async {
    final prefs = await _instance;
    return prefs.getString(full_name) ?? "";
  }

  static Future<void> setEmail(String value) async {
    final prefs = await _instance;
    prefs.setString(email, value);
  }

  static Future<String?> getEmail() async {
    final prefs = await _instance;
    return prefs.getString(email) ?? "";
  }

  static Future<void> setUserName(String userName) async {
    final prefs = await _instance;
    prefs.setString(user_name, userName);
  }

  static Future<String?> getUserName() async {
    final prefs = await _instance;
    return prefs.getString(user_name) ?? "";
  }

  static Future<void> setMobileNo(String userName) async {
    final prefs = await _instance;
    prefs.setString(mobile_number, userName);
  }

  static Future<String?> getMobileNo() async {
    final prefs = await _instance;
    return prefs.getString(mobile_number) ?? "";
  }

  static Future<void> setFcmToken(String token) async {
    final prefs = await _instance;
    prefs.setString(fcm_token, token);
  }

  static Future<String?> getFcmToken() async {
    final prefs = await _instance;
    return prefs.getString(fcm_token) ?? "";
  }

  ///TO CLEAR DATA
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
