import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static final _sharedInstance = Auth._internal();

  Auth._internal();

  static Auth getInstance() {
    return _sharedInstance;
  }

  static final _instance = SharedPreferences.getInstance();

  static final String user_id = "USERID";
  static final String intro_check = "INTRO_CHECK";
  static final String atm_officer_id = "ATM_OFFICER_ID";
  static final String atm_office_name = "ATM_OFFICER_NAMe";
  static final String sign_in_status = "SIGN_IN";
  static final String work_manger = "WORK_MANAGER";
  static final String signin_date = "CURRENT_DATE";

  static Future<void> setUserID(String userName) async {
    final prefs = await _instance;
    prefs.setString(user_id, userName);
  }

  static Future<String?> getUserID() async {
    final prefs = await _instance;
    return prefs.getString(user_id) ?? "";
  }

  static Future<void> setATMOffoceName(String vale) async {
    final prefs = await _instance;
    prefs.setString(atm_office_name, vale);
  }

  static Future<String?> getATMOffoceName() async {
    final prefs = await _instance;
    return prefs.getString(atm_office_name) ?? "";
  }

  static Future<void> setAtmOfficerId(String vale) async {
    final prefs = await _instance;
    prefs.setString(atm_officer_id, vale);
  }

  static Future<String?> getAtmOfficerId() async {
    final prefs = await _instance;
    return prefs.getString(atm_officer_id) ?? "";
  }

  static Future<void> setIsIntroCheck(String introCheck) async {
    final prefs = await _instance;
    prefs.setString(intro_check, introCheck);
  }

  static Future<String?> getIsIntroCheck() async {
    final prefs = await _instance;
    return prefs.getString(intro_check) ?? "";
  }

  static Future<void> setSignInCheck(String input) async {
    final prefs = await _instance;
    prefs.setString(sign_in_status, input);
  }

  static Future<String?> getSignInCheck() async {
    final prefs = await _instance;
    return prefs.getString(sign_in_status) ?? "0";
  }

  static Future<void> setWorkManger(bool input) async {
    final prefs = await _instance;
    prefs.setBool(work_manger, input);
  }

  static Future<bool?> getWorkManger() async {
    final prefs = await _instance;
    return prefs.getBool(work_manger) ?? true;
  }

  static Future<void> setSignInDate(String input) async {
    final prefs = await _instance;
    prefs.setString(signin_date, input);
  }

  static Future<String?> getSignInDate() async {
    final prefs = await _instance;
    return prefs.getString(signin_date) ?? "";
  }

  ///TO CLEAR DATA
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
