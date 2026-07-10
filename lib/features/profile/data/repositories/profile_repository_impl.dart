import 'package:flutter_ui_components/core/network/network_info.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/core/services/preference_keys.dart';
import 'package:flutter_ui_components/core/utils/exception_mapper.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/core/utils/failures.dart';
import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:flutter_ui_components/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_ui_components/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required ProfileRemoteDataSource remoteDataSource,
    required ProfileLocalDataSource localDataSource,
    required LocalStorage localStorage,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _localStorage = localStorage,
        _networkInfo = networkInfo;

  final ProfileRemoteDataSource _remoteDataSource;
  final ProfileLocalDataSource _localDataSource;
  final LocalStorage _localStorage;
  final NetworkInfo _networkInfo;

  @override
  Future<Result<ProfileEntity>> getProfile({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh) {
        final cached = await _localDataSource.getCachedProfile();
        if (cached != null) {
          return Result.success(cached.toEntity());
        }
      }

      final userId = _localStorage.getString(PreferenceKeys.currentUserId);
      if (userId == null || userId.isEmpty) {
        return const Result.failure(
          ValidationFailure(message: 'No authenticated user found.'),
        );
      }

      if (!await _networkInfo.isConnected) {
        final cached = await _localDataSource.getCachedProfile();
        if (cached != null) {
          return Result.success(cached.toEntity());
        }
        return const Result.failure(NetworkFailure());
      }

      final remoteProfile = await _remoteDataSource.getProfile(userId);
      await _localDataSource.cacheProfile(remoteProfile);
      return Result.success(remoteProfile.toEntity());
    } on AppException catch (error) {
      return Result.failure(ExceptionMapper.toFailure(error));
    } catch (error) {
      return Result.failure(UnknownFailure(message: error.toString()));
    }
  }
}
