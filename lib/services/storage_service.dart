// ignore_for_file: unused_field

import 'package:my_todo/utils/constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _pref;

  Future<StorageService> initStorage() async {
    _pref = await SharedPreferences.getInstance();

    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return _pref.setBool(key, value);
  }

  Future<bool> setString(String key, String value) {
    return _pref.setString(key, value);
  }

  bool getDeviceFirstOpen() {
    return _pref.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  bool isLoggedIn() {
    return _pref.getString(AppConstants.STORAGE_USER_TOKEN_KEY) == null
        ? false
        : true;
  }

  Future<bool> removeToken(String key) {
    return _pref.remove(key);
  }
}
