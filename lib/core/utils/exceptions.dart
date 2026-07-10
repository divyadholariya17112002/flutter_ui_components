/// Base class for data-layer exceptions.
abstract class AppException implements Exception {
  const AppException({required this.message, this.code});

  final String message;
  final String? code;
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection.',
    super.code = 'network_error',
  });
}

class TimeoutException extends AppException {
  const TimeoutException({
    super.message = 'Request timed out.',
    super.code = 'timeout_error',
  });
}

class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code = 'server_error',
  });
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Session expired. Please sign in again.',
    super.code = 'unauthorized',
  });
}

class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message = 'You do not have permission to perform this action.',
    super.code = 'forbidden',
  });
}

class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'The requested resource was not found.',
    super.code = 'not_found',
  });
}

class ApiValidationException extends AppException {
  const ApiValidationException({
    super.message = 'Validation failed.',
    super.code = 'validation_error',
  });
}

class CancelledException extends AppException {
  const CancelledException({
    super.message = 'Request was cancelled.',
    super.code = 'cancelled',
  });
}

class CacheException extends AppException {
  const CacheException({
    super.message = 'Failed to access local storage.',
    super.code = 'cache_error',
  });
}

class ParsingException extends AppException {
  const ParsingException({
    super.message = 'Failed to parse response.',
    super.code = 'parsing_error',
  });
}

class UnknownFailureException extends AppException {
  const UnknownFailureException({
    super.message = 'An unexpected error occurred.',
    super.code = 'unknown_error',
  });
}
