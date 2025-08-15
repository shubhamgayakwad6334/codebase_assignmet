import 'dart:convert';

import 'package:codebase_assignment/core/utils/constants/app_constants.dart';
import 'package:codebase_assignment/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static late SharedPreferences _prefs;
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  factory SharedPrefHelper() {
    return _instance;
  }

  SharedPrefHelper._internal();

  // Method to delete all data securely
  static Future<void> deleteAll() async {
    await _prefs.clear();
  }

  static void setUserDetails({required UserModel user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final encodedData = jsonEncode(user);
    prefs.setString(AppConstants.userDataKey, encodedData);
  }

  static Future<UserModel?> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(AppConstants.userDataKey);
    if (userJson != null) {
      Map<String, dynamic> userMap = json.decode(userJson);
      return UserModel.fromJson(userMap);
    }
    return null;
  }
}
