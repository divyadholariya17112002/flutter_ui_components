import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_local_data_source.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:flutter_ui_components/features/profile/data/models/profile_model.dart';

/// Simulated profile API backed by the locally cached authenticated user.
class FakeProfileRemoteDataSource implements ProfileRemoteDataSource {
  FakeProfileRemoteDataSource({required AuthLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  final AuthLocalDataSource _localDataSource;

  static const Duration networkDelay = Duration(milliseconds: 600);

  @override
  Future<ProfileModel> getProfile(String userId) async {
    await Future<void>.delayed(networkDelay);

    final user = await _localDataSource.getCachedUser();
    if (user == null || user.id.toString() != userId) {
      throw const ServerException(
        message: 'Profile not found.',
        code: 'profile_not_found',
      );
    }

    return ProfileModel(
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      avatar: user.avatar,
    );
  }
}
