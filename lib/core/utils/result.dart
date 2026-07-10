import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_ui_components/core/utils/failures.dart';

part 'result.freezed.dart';

/// Functional result type used across the domain and data layers.
@freezed
sealed class Result<T> with _$Result<T> {
  const Result._();

  const factory Result.success(T data) = Success<T>;

  const factory Result.failure(Failure failure) = Error<T>;

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Error<T>;

  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        Error<T>() => null,
      };

  Failure? get failureOrNull => switch (this) {
        Success<T>() => null,
        Error<T>(:final failure) => failure,
      };
}
