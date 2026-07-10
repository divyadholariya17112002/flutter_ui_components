import 'package:dio/dio.dart';
import 'package:flutter_ui_components/core/config/api_constants.dart';
import 'package:flutter_ui_components/core/utils/app_logger.dart';

/// Structured HTTP logging via [AppLogger].
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({this.logRequestBody = true, this.logResponseBody = false});

  final bool logRequestBody;
  final bool logResponseBody;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..writeln('┌────── HTTP REQUEST ──────')
      ..writeln('│ ${options.method} ${options.uri}')
      ..writeln('│ Headers: ${_sanitizeHeaders(options.headers)}');

    if (logRequestBody && options.data != null) {
      buffer.writeln('│ Body: ${options.data}');
    }

    buffer.write('└──────────────────────────');
    AppLogger.debug(buffer.toString());
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final buffer = StringBuffer()
      ..writeln('┌────── HTTP RESPONSE ──────')
      ..writeln('│ ${response.statusCode} ${response.requestOptions.uri}');

    if (logResponseBody && response.data != null) {
      buffer.writeln('│ Body: ${response.data}');
    }

    buffer.write('└───────────────────────────');
    AppLogger.debug(buffer.toString());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
      'HTTP ERROR [${err.response?.statusCode}] ${err.requestOptions.uri}',
      err,
    );
    handler.next(err);
  }

  Map<String, dynamic> _sanitizeHeaders(Map<String, dynamic> headers) {
    final sanitized = Map<String, dynamic>.from(headers);
    final authKey = ApiConstants.authorization;

    if (sanitized.containsKey(authKey)) {
      sanitized[authKey] = '***';
    }

    return sanitized;
  }
}
