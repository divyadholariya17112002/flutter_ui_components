import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/provider/view_model.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/core/services/preference_keys.dart';

/// Manages app-wide preferences: theme, language, and notifications.
class SettingsViewModel extends ViewModel {
  SettingsViewModel({required LocalStorage localStorage})
      : _localStorage = localStorage;

  final LocalStorage _localStorage;

  ThemeMode _themeMode = ThemeMode.system;
  bool _notificationsEnabled = true;
  String _language = 'en';
  bool _initialized = false;

  ThemeMode get themeMode => _themeMode;
  bool get notificationsEnabled => _notificationsEnabled;
  String get language => _language;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    final savedTheme = _localStorage.getString(PreferenceKeys.themeMode);
    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.name == savedTheme,
        orElse: () => ThemeMode.system,
      );
    }

    _notificationsEnabled =
        _localStorage.getBool(PreferenceKeys.notificationsEnabled) ?? true;
    _language = _localStorage.getString(PreferenceKeys.language) ?? 'en';
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _localStorage.setString(PreferenceKeys.themeMode, mode.name);
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool enabled) {
    return setThemeMode(enabled ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    _notificationsEnabled = enabled;
    await _localStorage.setBool(PreferenceKeys.notificationsEnabled, enabled);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    _language = languageCode;
    await _localStorage.setString(PreferenceKeys.language, languageCode);
    notifyListeners();
  }
}
