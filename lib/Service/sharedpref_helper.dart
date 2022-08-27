import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userNameKey = "USERNAMEKEY";
  static String userDaigaku = "USERDAIGAKU";

  //save data
  Future<bool> saveUserName(String? userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, userName!);
  }

  Future<bool> saveUserDaigaku(String? userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userDaigaku, userName!);
  }

  //get data
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserDaigaku() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userDaigaku);
  }
}
