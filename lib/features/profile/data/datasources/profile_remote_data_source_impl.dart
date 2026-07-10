import 'package:flutter_ui_components/core/network/api_client.dart';
import 'package:flutter_ui_components/core/network/models/api_request_config.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_endpoints.dart';
import 'package:flutter_ui_components/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:flutter_ui_components/features/profile/data/models/profile_model.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  ProfileRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<ProfileModel> getProfile(String userId) async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        ProfileEndpoints.userById(userId),
        config: const ApiRequestConfig(skipAuth: true),
      );

      return ProfileResponseModel.fromJson(response.data ?? {}).data;
    } on AppException {
      rethrow;
    } catch (error) {
      throw ParsingException(message: error.toString());
    }
  }
}
