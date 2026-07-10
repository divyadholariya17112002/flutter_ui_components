import 'package:flutter_ui_components/features/home/data/models/home_item_model.dart';

abstract interface class HomeLocalDataSource {
  Future<void> cacheHomeItems(List<HomeItemModel> items);

  Future<List<HomeItemModel>?> getCachedHomeItems();
}
