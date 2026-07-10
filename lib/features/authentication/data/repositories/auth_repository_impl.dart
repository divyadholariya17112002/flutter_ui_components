import 'package:flutter_ui_components/core/utils/exception_mapper.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/core/utils/failures.dart';
import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/remembered_credentials.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/user_entity.dart';
import 'package:flutter_ui_components/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final userModel = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      await _localDataSource.cacheUser(userModel);
      await _localDataSource.persistRememberMe(
        enabled: rememberMe,
        email: email,
      );

      return Result.success(userModel.toEntity());
    } on AppException catch (error) {
      return Result.failure(ExceptionMapper.toFailure(error));
    } catch (error) {
      return Result.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _localDataSource.clearSession();
      return const Result.success(null);
    } on AppException catch (error) {
      return Result.failure(ExceptionMapper.toFailure(error));
    } catch (error) {
      return Result.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<Result<UserEntity?>> getCachedUser() async {
    try {
      final cached = await _localDataSource.getCachedUser();
      return Result.success(cached?.toEntity());
    } on AppException catch (error) {
      return Result.failure(ExceptionMapper.toFailure(error));
    } catch (error) {
      return Result.failure(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<Result<bool>> isAuthenticated() async {
    final cachedResult = await getCachedUser();
    return cachedResult.isSuccess
        ? Result.success(cachedResult.dataOrNull != null)
        : Result.failure(cachedResult.failureOrNull!);
  }

  @override
  Future<Result<RememberedCredentials>> getRememberedCredentials() async {
    try {
      final credentials = await _localDataSource.getRememberedCredentials();
      return Result.success(credentials);
    } on AppException catch (error) {
      return Result.failure(ExceptionMapper.toFailure(error));
    } catch (error) {
      return Result.failure(UnknownFailure(message: error.toString()));
    }
  }
}
