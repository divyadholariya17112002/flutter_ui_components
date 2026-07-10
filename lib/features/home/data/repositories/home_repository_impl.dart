import 'package:flutter_ui_components/core/network/network_info.dart';
import 'package:flutter_ui_components/core/utils/exception_mapper.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/core/utils/failures.dart';
import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/features/home/data/datasources/home_local_data_source.dart';
import 'package:flutter_ui_components/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_ui_components/features/home/domain/entities/home_item_entity.dart';
import 'package:flutter_ui_components/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required HomeRemoteDataSource remoteDataSource,
    required HomeLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Result<List<HomeItemEntity>>> getHomeItems({
    bool forceRefresh = false,
  }) async {
    try {
      if (!forceRefresh) {
        final cached = await _localDataSource.getCachedHomeItems();
        if (cached != null && cached.isNotEmpty) {
          return Result.success(cached.map((item) => item.toEntity()).toList());
        }
      }

      if (!await _networkInfo.isConnected) {
        final cached = await _localDataSource.getCachedHomeItems();
        if (cached != null) {
          return Result.success(cached.map((item) => item.toEntity()).toList());
        }
        return const Result.failure(NetworkFailure());
      }

      final remoteItems = await _remoteDataSource.getHomeItems();
      await _localDataSource.cacheHomeItems(remoteItems);
      return Result.success(remoteItems.map((item) => item.toEntity()).toList());
    } on AppException catch (error) {
      return Result.failure(ExceptionMapper.toFailure(error));
    } catch (error) {
      return Result.failure(UnknownFailure(message: error.toString()));
    }
  }
}
