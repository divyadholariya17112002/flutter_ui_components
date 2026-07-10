import 'package:flutter_ui_components/core/network/api_client.dart';
import 'package:flutter_ui_components/core/network/models/api_request_config.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/features/home/data/datasources/home_endpoints.dart';
import 'package:flutter_ui_components/features/home/data/datasources/home_remote_data_source.dart';
import 'package:flutter_ui_components/features/home/data/models/home_item_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  final ApiClient _apiClient;

  @override
  Future<List<HomeItemModel>> getHomeItems() async {
    try {
      final response = await _apiClient.get<Map<String, dynamic>>(
        HomeEndpoints.users,
        queryParameters: {'page': 1},
        config: const ApiRequestConfig(skipAuth: true),
      );

      return HomeUsersResponseModel.fromJson(response.data ?? {}).data;
    } on AppException {
      rethrow;
    } catch (error) {
      throw ParsingException(message: error.toString());
    }
  }
}
