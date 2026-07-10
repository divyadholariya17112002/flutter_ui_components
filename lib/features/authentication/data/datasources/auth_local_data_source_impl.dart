import 'dart:convert';

import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/core/services/preference_keys.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:flutter_ui_components/features/authentication/data/models/user_model.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/remembered_credentials.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required LocalStorage localStorage})
      : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final encoded = jsonEncode(user.toJson());
      await _localStorage.setString(PreferenceKeys.cachedUser, encoded);
      await _localStorage.setAccessToken(user.token);
      await _localStorage.setString(
        PreferenceKeys.currentUserId,
        user.id.toString(),
      );
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final raw = _localStorage.getString(PreferenceKeys.cachedUser);
      if (raw == null || raw.isEmpty) return null;

      return UserModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await _localStorage.remove(PreferenceKeys.cachedUser);
      await _localStorage.remove(PreferenceKeys.currentUserId);
      await _localStorage.remove(PreferenceKeys.accessToken);
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }

  @override
  Future<void> persistRememberMe({
    required bool enabled,
    required String email,
  }) async {
    try {
      await _localStorage.setBool(PreferenceKeys.rememberMe, enabled);

      if (enabled) {
        await _localStorage.setString(
          PreferenceKeys.rememberedEmail,
          email.trim(),
        );
      } else {
        await _localStorage.remove(PreferenceKeys.rememberedEmail);
      }
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }

  @override
  Future<RememberedCredentials> getRememberedCredentials() async {
    try {
      final rememberMe =
          _localStorage.getBool(PreferenceKeys.rememberMe) ?? false;
      final email = _localStorage.getString(PreferenceKeys.rememberedEmail);

      return RememberedCredentials(
        rememberMe: rememberMe,
        email: email ?? '',
      );
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }
}
