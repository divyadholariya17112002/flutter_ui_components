import 'package:dio/dio.dart';
import 'package:flutter_ui_components/core/config/api_constants.dart';
import 'package:flutter_ui_components/core/network/models/api_request_config.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';

/// Attaches the bearer token from [LocalStorage] to outgoing requests.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required LocalStorage localStorage})
      : _localStorage = localStorage;

  final LocalStorage _localStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final config = _readConfig(options);

    if (!config.skipAuth) {
      final token = _localStorage.accessToken;
      if (token != null && token.isNotEmpty) {
        options.headers[ApiConstants.authorization] =
            '${ApiConstants.bearerPrefix} $token';
      }
    }

    handler.next(options);
  }

  ApiRequestConfig _readConfig(RequestOptions options) {
    final extra = options.extra[ApiConstants.requestConfigKey];
    if (extra is ApiRequestConfig) return extra;
    return ApiRequestConfig.defaults;
  }
}
