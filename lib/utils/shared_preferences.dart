import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExtension on SharedPreferences {
  Future<void> setStringIfAbsent(String key, String value) async {
    if (getString(key) == null) {
      await setString(key, value);
    }
  }

  Future<void> setIntIfAbsent(String key, int value) async {
    if (getInt(key) == null) {
      await setInt(key, value);
    }
  }

  Future<void> setStringListIfAbsent(String key, List<String> value) async {
    if (getStringList(key) == null) {
      await setStringList(key, value);
    }
  }

  Future<void> setBoolIfAbsent(String key, bool value) async {
    if (getBool(key) == null) {
      await setBool(key, value);
    }
  }

  bool getSafeBool(String key, [bool inverse = false]) {
    final bool? k = getBool(key);
    return k == null || !k ? inverse : true;
  }
}
