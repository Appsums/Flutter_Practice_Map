import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFile {
  clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
    } catch (e) {
      print(e);
    }
  }
  //********** Int value **************
  Future<int> readInt(keys) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = keys;

      final value = prefs.getInt(key) ?? -1;

      return value;
    } catch (e) {
      print(e);
      return -1;
    }
  }
  saveInt(keys,values) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = keys;
      final value = values;
      prefs.setInt(key, value);

    } catch (e) {
      print(e);
    }
  }

 //********** String value **************
  Future<String> readStr(keys) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = keys;

      final value = prefs.getString(key) ?? null;

      return value;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> saveStr(keys,values) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = keys;
      final value = values;
      prefs.setString(key, value);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
//is_user_loggedin
  //********** Bool value **************
  Future<bool> readBool(keys) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = keys;

      final value = prefs.getBool(key) ?? false;

      return value;
    } catch (e) {
      print(e);
      return false;
    }
  }
  saveBool(keys,values) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = keys;
      final value = values;

      prefs.setBool(key, value);

    } catch (e) {
      print(e);
    }
  }

  //********** Bool value **************
  Future<dynamic> readDouble(keys) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = keys;

      final value = prefs.getDouble(key) ?? -1;

      return value;
    } catch (e) {
      print(e);
      return false;
    }
  }
  saveDouble(keys,values) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = keys;
      final value = values;
      prefs.setDouble(key, value);

    } catch (e) {
      print(e);
    }
  }
}