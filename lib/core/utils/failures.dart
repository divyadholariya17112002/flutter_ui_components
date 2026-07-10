import 'package:equatable/equatable.dart';

/// Base class for domain-layer failures.
abstract class Failure extends Equatable {
  const Failure({required this.message, this.code});

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

/// Failure when the device has no network connectivity.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection.',
    super.code = 'network_error',
  });
}

/// Failure when the remote server returns an error response.
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code = 'server_error',
  });
}

/// Failure when local cache or persistence operations fail.
class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Failed to access local storage.',
    super.code = 'cache_error',
  });
}

/// Failure for input validation errors.
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code = 'validation_error',
  });
}

/// Failure for unexpected or unhandled errors.
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred.',
    super.code = 'unknown_error',
  });
}
