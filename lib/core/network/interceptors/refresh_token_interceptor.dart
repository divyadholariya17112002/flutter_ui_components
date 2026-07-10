import 'package:dio/dio.dart';
import 'package:flutter_ui_components/core/config/api_constants.dart';
import 'package:flutter_ui_components/core/network/auth/token_refresh_handler.dart';
import 'package:flutter_ui_components/core/network/models/api_request_config.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';

/// Intercepts HTTP 401 responses and attempts a token refresh before retrying.
///
/// Uses [PlaceholderTokenRefreshHandler] until a real refresh flow is wired.
class RefreshTokenInterceptor extends QueuedInterceptor {
  RefreshTokenInterceptor({
    required TokenRefreshHandler tokenRefreshHandler,
    required LocalStorage localStorage,
    required Dio dio,
  })  : _tokenRefreshHandler = tokenRefreshHandler,
        _localStorage = localStorage,
        _dio = dio;

  final TokenRefreshHandler _tokenRefreshHandler;
  final LocalStorage _localStorage;
  final Dio _dio;

  static const _retryKey = 'retried_after_refresh';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldAttemptRefresh(err)) {
      return handler.next(err);
    }

    err.requestOptions.extra[_retryKey] = true;

    try {
      final newToken = await _tokenRefreshHandler.refresh();

      if (newToken == null || newToken.isEmpty) {
        await _tokenRefreshHandler.onRefreshFailed();
        return handler.next(err);
      }

      await _localStorage.setAccessToken(newToken);

      final response = await _dio.fetch<dynamic>(err.requestOptions);
      return handler.resolve(response);
    } catch (refreshError) {
      await _tokenRefreshHandler.onRefreshFailed();
      return handler.next(err);
    }
  }

  bool _shouldAttemptRefresh(DioException err) {
    if (err.response?.statusCode != 401) return false;
    if (err.requestOptions.extra[_retryKey] == true) return false;

    final config = err.requestOptions.extra[ApiConstants.requestConfigKey];
    if (config is ApiRequestConfig && config.skipAuth) return false;

    return true;
  }
}
