import 'package:flutter_ui_components/core/utils/result.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/remembered_credentials.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Result<UserEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<Result<void>> logout();

  Future<Result<UserEntity?>> getCachedUser();

  Future<Result<bool>> isAuthenticated();

  Future<Result<RememberedCredentials>> getRememberedCredentials();
}
