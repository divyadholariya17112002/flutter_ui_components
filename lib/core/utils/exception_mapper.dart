import 'package:flutter_ui_components/core/utils/exceptions.dart';
import 'package:flutter_ui_components/core/utils/failures.dart';

abstract final class ExceptionMapper {
  static Failure toFailure(AppException exception) {
    return switch (exception) {
      NetworkException() => NetworkFailure(
          message: exception.message,
          code: exception.code,
        ),
      TimeoutException() => NetworkFailure(
          message: exception.message,
          code: exception.code,
        ),
      ServerException() => ServerFailure(
          message: exception.message,
          code: exception.code,
        ),
      UnauthorizedException() => ServerFailure(
          message: exception.message,
          code: exception.code,
        ),
      ForbiddenException() => ServerFailure(
          message: exception.message,
          code: exception.code,
        ),
      NotFoundException() => ServerFailure(
          message: exception.message,
          code: exception.code,
        ),
      ApiValidationException() => ValidationFailure(
          message: exception.message,
          code: exception.code,
        ),
      CacheException() => CacheFailure(
          message: exception.message,
          code: exception.code,
        ),
      ParsingException() => UnknownFailure(
          message: exception.message,
          code: exception.code,
        ),
      _ => UnknownFailure(
          message: exception.message,
          code: exception.code,
        ),
    };
  }
}
