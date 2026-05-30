import 'dart:ffi';

import 'package:crashid/data_sources/local_storage/share_preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  late final SharedPreferences _sharedPrefs;

  // Call this once during app startup
  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  bool get isFirstTime =>
      _sharedPrefs.getBool(SharePreferenceKeys.IS_FIRST_TIME.name) ?? false;
  set setFirstTime(bool value) =>
      _sharedPrefs.setBool(SharePreferenceKeys.IS_FIRST_TIME.name, value);

  bool get isRememberMe =>
      _sharedPrefs.getBool(SharePreferenceKeys.IS_REMEMBER_ME.name) ?? false;
  set setIsRememberMe(bool value) =>
      _sharedPrefs.setBool(SharePreferenceKeys.IS_REMEMBER_ME.name, value);

  String get language =>
      _sharedPrefs.getString(SharePreferenceKeys.LANGUAGE.name) ?? '';
  set setLanguage(String value) =>
      _sharedPrefs.setString(SharePreferenceKeys.LANGUAGE.name, value);

  String get email =>
      _sharedPrefs.getString(SharePreferenceKeys.EMAIL.name) ?? '';
  set setEmail(String value) =>
      _sharedPrefs.setString(SharePreferenceKeys.EMAIL.name, value);

  String get password =>
      _sharedPrefs.getString(SharePreferenceKeys.PASSWORD.name) ?? '';
  set setPassword(String value) =>
      _sharedPrefs.setString(SharePreferenceKeys.PASSWORD.name, value);

  String get fcmToken =>
      _sharedPrefs.getString(SharePreferenceKeys.FCM_TOKEN.name) ?? '';
  set setFcmToken(String value) =>
      _sharedPrefs.setString(SharePreferenceKeys.FCM_TOKEN.name, value);

  String get userId =>
      _sharedPrefs.getString(SharePreferenceKeys.USER_ID.name) ?? '';
  set setUserId(String value) =>
      _sharedPrefs.setString(SharePreferenceKeys.USER_ID.name, value);

  bool get carAdded =>
      _sharedPrefs.getBool(SharePreferenceKeys.Is_CAR_ADDED.name) ?? false;
  set setCarAdded(bool value) =>
      _sharedPrefs.setBool(SharePreferenceKeys.Is_CAR_ADDED.name, value);

  void clearValues() {
    _sharedPrefs.clear();
  }
}
