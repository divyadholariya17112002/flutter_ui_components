import 'package:flutter_ui_components/core/services/preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Thin abstraction over [SharedPreferences] for testability and SOLID compliance.
class LocalStorage {
  LocalStorage(this._preferences);

  final SharedPreferences _preferences;

  String? getString(String key) => _preferences.getString(key);

  Future<bool> setString(String key, String value) =>
      _preferences.setString(key, value);

  bool? getBool(String key) => _preferences.getBool(key);

  Future<bool> setBool(String key, bool value) => _preferences.setBool(key, value);

  int? getInt(String key) => _preferences.getInt(key);

  Future<bool> setInt(String key, int value) => _preferences.setInt(key, value);

  Future<bool> remove(String key) => _preferences.remove(key);

  Future<bool> clear() => _preferences.clear();

  // Convenience accessors — extend as features require persisted values.

  String? get accessToken => getString(PreferenceKeys.accessToken);

  Future<bool> setAccessToken(String value) =>
      setString(PreferenceKeys.accessToken, value);

  bool get isFirstLaunch =>
      getBool(PreferenceKeys.isFirstLaunch) ?? true;

  Future<bool> setFirstLaunchCompleted() =>
      setBool(PreferenceKeys.isFirstLaunch, false);
}
