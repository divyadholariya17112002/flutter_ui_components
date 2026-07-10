import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/features/home/domain/entities/home_item_entity.dart';

abstract interface class HomeRepository {
  Future<Result<List<HomeItemEntity>>> getHomeItems({bool forceRefresh = false});
}
