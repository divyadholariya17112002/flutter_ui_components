import 'package:dio/dio.dart';
import 'package:flutter_ui_components/core/utils/exceptions.dart';

/// Centralized mapping of [DioException] and unknown errors to [AppException].
abstract final class ApiErrorHandler {
  static AppException fromDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = _extractErrorMessage(error);

    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        TimeoutException(message: message ?? 'Request timed out.'),
      DioExceptionType.connectionError ||
      DioExceptionType.unknown when _isSocketError(error) =>
        const NetworkException(),
      DioExceptionType.badResponse => _fromStatusCode(statusCode, message),
      DioExceptionType.cancel => CancelledException(
          message: message ?? 'Request was cancelled.',
        ),
      DioExceptionType.badCertificate => const NetworkException(
          message: 'Invalid SSL certificate.',
        ),
      _ => ServerException(
          message: message ?? 'Request failed.',
          code: statusCode?.toString(),
        ),
    };
  }

  static AppException fromUnknown(Object error) {
    if (error is AppException) return error;
    if (error is DioException) return fromDioException(error);
    return UnknownFailureException(message: error.toString());
  }

  static AppException _fromStatusCode(int? statusCode, String? message) {
    if (statusCode != null && statusCode >= 500 && statusCode < 600) {
      return ServerException(
        message: message ?? 'Server error occurred.',
        code: statusCode.toString(),
      );
    }

    return switch (statusCode) {
      401 => UnauthorizedException(message: message ?? 'Unauthorized.'),
      403 => ForbiddenException(message: message ?? 'Forbidden.'),
      404 => NotFoundException(message: message ?? 'Not found.'),
      422 => ApiValidationException(message: message ?? 'Validation failed.'),
      _ => ServerException(
          message: message ?? 'Request failed.',
          code: statusCode?.toString(),
        ),
    };
  }

  static String? _extractErrorMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      return data['message'] as String? ??
          data['error'] as String? ??
          data['detail'] as String?;
    }

    if (data is String && data.isNotEmpty) {
      return data;
    }

    return error.message;
  }

  static bool _isSocketError(DioException error) {
    return error.message?.toLowerCase().contains('socket') ?? false;
  }
}
