import 'package:dio/dio.dart';
import 'package:flutter_ui_components/core/config/api_constants.dart';
import 'package:flutter_ui_components/core/network/models/api_request_config.dart';

/// Retries transient failures with exponential backoff.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    required this.maxAttempts,
    required this.baseDelay,
    this.retryableStatusCodes = const {408, 429, 500, 502, 503, 504},
  });

  final Dio dio;
  final int maxAttempts;
  final Duration baseDelay;
  final Set<int> retryableStatusCodes;

  static const _attemptKey = 'retry_attempt';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final config = _readConfig(err.requestOptions);
    if (!config.enableRetry) return handler.next(err);

    final maxRetries = config.maxRetries ?? maxAttempts;
    final attempt = (err.requestOptions.extra[_attemptKey] as int?) ?? 0;

    if (!_shouldRetry(err, attempt, maxRetries)) {
      return handler.next(err);
    }

    err.requestOptions.extra[_attemptKey] = attempt + 1;

    final delay = baseDelay * (attempt + 1);
    await Future<void>.delayed(delay);

    try {
      final response = await dio.fetch<dynamic>(err.requestOptions);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      return handler.next(retryError);
    }
  }

  bool _shouldRetry(DioException err, int attempt, int maxRetries) {
    if (attempt >= maxRetries) return false;

    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    final statusCode = err.response?.statusCode;
    return statusCode != null && retryableStatusCodes.contains(statusCode);
  }

  ApiRequestConfig _readConfig(RequestOptions options) {
    final extra = options.extra[ApiConstants.requestConfigKey];
    if (extra is ApiRequestConfig) return extra;
    return ApiRequestConfig.defaults;
  }
}
