import 'package:flutter_ui_components/features/home/data/models/home_item_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<HomeItemModel>> getHomeItems();
}
