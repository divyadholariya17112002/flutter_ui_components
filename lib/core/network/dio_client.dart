import 'package:dio/dio.dart';
import 'package:flutter_ui_components/core/config/api_constants.dart';
import 'package:flutter_ui_components/core/network/auth/token_refresh_handler.dart';
import 'package:flutter_ui_components/core/network/interceptors/api_key_interceptor.dart';
import 'package:flutter_ui_components/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_ui_components/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter_ui_components/core/network/interceptors/refresh_token_interceptor.dart';
import 'package:flutter_ui_components/core/network/interceptors/retry_interceptor.dart';
import 'package:flutter_ui_components/core/config/app_config.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';

/// Factory that builds a fully configured [Dio] instance with interceptors.
class DioClient {
  DioClient({
    required AppConfig config,
    required LocalStorage localStorage,
    TokenRefreshHandler? tokenRefreshHandler,
  })  : _config = config,
        _localStorage = localStorage,
        _tokenRefreshHandler =
            tokenRefreshHandler ?? PlaceholderTokenRefreshHandler();

  final AppConfig _config;
  final LocalStorage _localStorage;
  final TokenRefreshHandler _tokenRefreshHandler;

  Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: _config.baseUrl,
        connectTimeout: _config.connectTimeout,
        receiveTimeout: _config.receiveTimeout,
        sendTimeout: _config.sendTimeout,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
        },
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    dio.interceptors.addAll([
      ApiKeyInterceptor(apiKey: _config.apiKey),
      AuthInterceptor(localStorage: _localStorage),
      if (_config.enableNetworkLogging) LoggingInterceptor(),
      RefreshTokenInterceptor(
        tokenRefreshHandler: _tokenRefreshHandler,
        localStorage: _localStorage,
        dio: dio,
      ),
      RetryInterceptor(
        dio: dio,
        maxAttempts: _config.maxRetryAttempts,
        baseDelay: _config.retryDelay,
      ),
    ]);

    return dio;
  }
}
