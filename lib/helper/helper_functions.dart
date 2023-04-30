import 'package:shared_preferences/shared_preferences.dart';

class helperFunctions {
  static String userLoggedInKey = "loggedinKey";
  static String userNameKey = "usernameKey";
  static String userEmailKey = "emailKey";
  static String userIDKey="userIDKey";

  static Future<bool> saveUserIDSF(String userID) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userIDKey, userID);
  }

  static Future<bool> saveLoginStatus(bool loginStatus) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, loginStatus);
  }

  static Future<bool> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName);
  }

  static Future<bool> saveEmailSF(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }

  static Future<bool?> getUserStatusSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<String?> getUserNameSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUserEmailSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }
}
