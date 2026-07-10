import 'package:dio/dio.dart';

/// Standardized wrapper around every HTTP response from [ApiClient].
class ApiResponse<T> {
  const ApiResponse({
    required this.statusCode,
    this.data,
    this.message,
    this.headers = const {},
    this.raw,
  });

  final int statusCode;
  final T? data;
  final String? message;
  final Map<String, List<String>> headers;
  final Response<T>? raw;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  bool get hasData => data != null;

  /// Builds an [ApiResponse] from a raw Dio [Response].
  factory ApiResponse.fromDio(Response<T> response) {
    return ApiResponse<T>(
      statusCode: response.statusCode ?? 0,
      data: response.data,
      message: _extractMessage(response.data),
      headers: response.headers.map,
      raw: response,
    );
  }

  /// Parses a typical `{ "data": ..., "message": "...", "success": true }` envelope.
  factory ApiResponse.fromEnvelope(
    Map<String, dynamic> json,
    T Function(dynamic json) parser,
  ) {
    final success = json['success'] as bool? ?? true;
    final statusCode = json['status_code'] as int? ?? (success ? 200 : 400);

    return ApiResponse<T>(
      statusCode: statusCode,
      data: json['data'] != null ? parser(json['data']) : null,
      message: json['message'] as String?,
    );
  }

  ApiResponse<R> map<R>(R Function(T value) transform) {
    if (data == null) {
      return ApiResponse<R>(
        statusCode: statusCode,
        message: message,
        headers: headers,
      );
    }

    return ApiResponse<R>(
      statusCode: statusCode,
      data: transform(data as T),
      message: message,
      headers: headers,
    );
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message'] as String? ?? data['error'] as String?;
    }
    return null;
  }
}
