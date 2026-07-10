import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_state.freezed.dart';

/// Standard UI state wrapper for MVVM ViewModels.
@freezed
sealed class ViewState<T> with _$ViewState<T> {
  const factory ViewState.idle() = Idle<T>;

  const factory ViewState.loading() = Loading<T>;

  const factory ViewState.success(T data) = Success<T>;

  const factory ViewState.error(String message) = ViewError<T>;
}

/// Convenience accessors for [ViewState] pattern matching in widgets.
extension ViewStateX<T> on ViewState<T> {
  bool get isIdle => this is Idle<T>;

  bool get isLoading => this is Loading<T>;

  bool get isSuccess => this is Success<T>;

  bool get isError => this is ViewError<T>;

  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        _ => null,
      };

  String? get errorMessage => switch (this) {
        ViewError<T>(:final message) => message,
        _ => null,
      };
}
