import 'package:flutter_ui_components/core/network/api_client.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_endpoints.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_ui_components/features/authentication/data/models/login_response_model.dart';
import 'package:flutter_ui_components/features/authentication/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginResponse = await _apiClient.post<Map<String, dynamic>>(
        AuthEndpoints.login,
        data: {'email': email, 'password': password},
      );

      final token = LoginResponseModel.fromJson(
        loginResponse.data ?? {},
      ).token;

      final userResponse = await _apiClient.get<Map<String, dynamic>>(
        AuthEndpoints.user,
      );

      final userData = UserResponseModel.fromJson(
        userResponse.data ?? {},
      ).data;

      return userData.copyWith(token: token);
    } on AppException {
      rethrow;
    } catch (error) {
      throw ParsingException(message: error.toString());
    }
  }
}
