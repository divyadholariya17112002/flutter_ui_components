import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_ui_components/features/authentication/data/models/user_model.dart';

/// Simulated login API for development and demos.
///
/// Valid credentials: `admin@example.com` / `Password@123`
class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  static const String demoEmail = 'admin@example.com';
  static const String demoPassword = 'Password@123';

  static const Duration networkDelay = Duration(milliseconds: 1500);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(networkDelay);

    if (email.trim().toLowerCase() != demoEmail ||
        password != demoPassword) {
      throw const ServerException(
        message: 'Invalid email or password. Please try again.',
        code: 'invalid_credentials',
      );
    }

    return const UserModel(
      id: 1,
      email: demoEmail,
      firstName: 'Admin',
      lastName: 'User',
      avatar: 'https://i.pravatar.cc/150?u=admin',
      token: 'fake-jwt-token',
    );
  }
}
