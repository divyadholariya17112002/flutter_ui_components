import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/core/utils/use_case.dart';
import 'package:flutter_ui_components/features/home/domain/entities/home_item_entity.dart';
import 'package:flutter_ui_components/features/home/domain/repositories/home_repository.dart';

class LoadHomeParams {
  const LoadHomeParams({this.forceRefresh = false});

  final bool forceRefresh;
}

class LoadHomeUseCase implements UseCase<List<HomeItemEntity>, LoadHomeParams> {
  LoadHomeUseCase({required HomeRepository repository})
      : _repository = repository;

  final HomeRepository _repository;

  @override
  Future<Result<List<HomeItemEntity>>> call(LoadHomeParams params) {
    return _repository.getHomeItems(forceRefresh: params.forceRefresh);
  }
}
