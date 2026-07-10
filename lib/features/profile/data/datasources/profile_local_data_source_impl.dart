import 'dart:convert';

import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/core/services/preference_keys.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:flutter_ui_components/features/profile/data/models/profile_model.dart';

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl({required LocalStorage localStorage})
      : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  Future<void> cacheProfile(ProfileModel profile) async {
    try {
      final encoded = jsonEncode(profile.toJson());
      await _localStorage.setString(PreferenceKeys.cachedProfile, encoded);
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }

  @override
  Future<ProfileModel?> getCachedProfile() async {
    try {
      final raw = _localStorage.getString(PreferenceKeys.cachedProfile);
      if (raw == null || raw.isEmpty) return null;

      return ProfileModel.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }
}
