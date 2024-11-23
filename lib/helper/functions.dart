import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String UserLoggedInKey = "USERLOGGEDINKEY";

  saveUserLoggedInDetails({bool? isLoggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(UserLoggedInKey, isLoggedin!);
  }

  getUserLoggedInDetails({bool? isLoggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool(UserLoggedInKey);
  }
}
