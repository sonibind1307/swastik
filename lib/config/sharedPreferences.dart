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

  static Future<void> setUserID(String userName) async {
    final prefs = await _instance;
    prefs.setString(user_id, userName);
  }

  static Future<String?> getUserID() async {
    final prefs = await _instance;
    return prefs.getString(user_id) ?? "";
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

  ///TO CLEAR DATA
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
