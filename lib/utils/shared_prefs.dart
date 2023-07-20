import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:sumeer/utils/utils.dart';

late SharedPreferences sharedPreferences;

Future<void> initializePrefs() async {
  sharedPreferences = await SharedPreferences.getInstance();
  debugPrint('Initialization of shared_prefs success');
}

/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
/// Add a value in SharedPref based on their type - Must be a String, int, bool, double, Map<String, dynamic> or StringList
Future<bool> setValue(String key, dynamic value, {bool print = true}) async {
  if (print) debugPrint('${value.runtimeType} - $key - $value');

  if (value is String) {
    return await sharedPreferences.setString(key, value.validate());
  } else if (value is int) {
    return await sharedPreferences.setInt(key, value.validate());
  } else if (value is bool) {
    return await sharedPreferences.setBool(key, value.validate());
  } else if (value is double) {
    return await sharedPreferences.setDouble(key, value.validate());
  } else if (value is Map<String, dynamic>) {
    return await sharedPreferences.setString(key, jsonEncode(value));
  } else if (value is List<String>) {
    return await sharedPreferences.setStringList(key, value);
  } else {
    throw ArgumentError(
      'Invalid value ${value.runtimeType} - Must be a String, int, bool, double, Map<String, dynamic> or StringList',
    );
  }
}

/// Returns List of Keys that matches with given Key
///
/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
List<String> getMatchingSharedPrefKeys(String key) {
  List<String> keys = [];

  sharedPreferences.getKeys().forEach((element) {
    if (element.contains(key)) {
      keys.add(element);
    }
  });

  return keys;
}

/// Returns a StringList if exists in SharedPref
///
/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
List<String>? getStringListAsync(String key) {
  return sharedPreferences.getStringList(key);
}

/// Returns a Bool if exists in SharedPref
///
/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
bool getBoolAsync(String key, {bool defaultValue = false}) {
  return sharedPreferences.getBool(key) ?? defaultValue;
}

/// Returns a Double if exists in SharedPref
///
/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
double getDoubleAsync(String key, {double defaultValue = 0.0}) {
  return sharedPreferences.getDouble(key) ?? defaultValue;
}

/// Returns a Int if exists in SharedPref
///
/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
int getIntAsync(String key, {int defaultValue = 0}) {
  return sharedPreferences.getInt(key) ?? defaultValue;
}

/// Returns a String if exists in SharedPref
///
/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
String getStringAsync(String key, {String defaultValue = ''}) {
  return sharedPreferences.getString(key) ?? defaultValue;
}

/// Returns a JSON if exists in SharedPref
///
/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
Map<String, dynamic> getJSONAsync(
  String key, {
  Map<String, dynamic>? defaultValue,
}) {
  return sharedPreferences.containsKey(key) &&
          sharedPreferences.getString(key).validate().isNotEmpty
      ? jsonDecode(sharedPreferences.getString(key)!)
      : defaultValue ?? {};
}

/// remove key from SharedPref
///
/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
Future<bool> removeKey(String key) async {
  return await sharedPreferences.remove(key);
}

/// clear SharedPref
///
/// These codes are from [nb_utils](https://pub.dev/packages/nb_utils)
/// package.
Future<bool> clearSharedPref() async {
  return await sharedPreferences.clear();
}
