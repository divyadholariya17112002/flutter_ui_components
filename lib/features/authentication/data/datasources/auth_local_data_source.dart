import 'package:flutter_ui_components/features/authentication/data/models/user_model.dart';
import 'package:flutter_ui_components/features/authentication/domain/entities/remembered_credentials.dart';

abstract interface class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);

  Future<UserModel?> getCachedUser();

  Future<void> clearSession();

  Future<void> persistRememberMe({
    required bool enabled,
    required String email,
  });

  Future<RememberedCredentials> getRememberedCredentials();
}
