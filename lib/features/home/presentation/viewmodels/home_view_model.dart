import 'package:flutter_ui_components/core/provider/base_view_model.dart';
import 'package:flutter_ui_components/features/home/domain/entities/home_item_entity.dart';
import 'package:flutter_ui_components/features/home/domain/usecases/load_home_use_case.dart';

class HomeViewModel extends BaseViewModel<List<HomeItemEntity>> {
  HomeViewModel({required LoadHomeUseCase loadHomeUseCase})
      : _loadHomeUseCase = loadHomeUseCase;

  final LoadHomeUseCase _loadHomeUseCase;

  Future<void> loadHomeItems({bool forceRefresh = false}) => execute(
        () => _loadHomeUseCase(LoadHomeParams(forceRefresh: forceRefresh)),
      );
}
