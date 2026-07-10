import 'dart:convert';

import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/core/services/preference_keys.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/features/home/data/datasources/home_local_data_source.dart';
import 'package:flutter_ui_components/features/home/data/models/home_item_model.dart';

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl({required LocalStorage localStorage})
      : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  Future<void> cacheHomeItems(List<HomeItemModel> items) async {
    try {
      final encoded = jsonEncode(items.map((item) => item.toJson()).toList());
      await _localStorage.setString(PreferenceKeys.cachedHomeItems, encoded);
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }

  @override
  Future<List<HomeItemModel>?> getCachedHomeItems() async {
    try {
      final raw = _localStorage.getString(PreferenceKeys.cachedHomeItems);
      if (raw == null || raw.isEmpty) return null;

      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((item) => HomeItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (error) {
      throw CacheException(message: error.toString());
    }
  }
}
