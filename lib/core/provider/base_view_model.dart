import 'package:flutter/foundation.dart';
import 'package:flutter_ui_components/core/provider/view_model.dart';
import 'package:flutter_ui_components/core/provider/view_state.dart';
import 'package:flutter_ui_components/core/utils/result.dart' as result;

/// Base ViewModel for data-driven screens.
///
/// Provides a typed [ViewState] with idle, loading, success, and error states,
/// plus helpers to map [Result] values from use cases.
abstract class BaseViewModel<T> extends ViewModel {
  ViewState<T> _state = const ViewState.idle();

  ViewState<T> get state => _state;

  bool get isIdle => _state.isIdle;

  bool get isLoading => _state.isLoading;

  bool get isSuccess => _state.isSuccess;

  bool get isError => _state.isError;

  T? get data => _state.dataOrNull;

  String? get errorMessage => _state.errorMessage;

  @protected
  set state(ViewState<T> value) {
    if (_state == value) return;
    _state = value;
    notifyListeners();
  }

  @protected
  void setIdle() => state = const ViewState.idle();

  @protected
  void setLoading() => state = const ViewState.loading();

  @protected
  void setSuccess(T data) => state = ViewState.success(data);

  @protected
  void setError(String message) => state = ViewState.error(message);

  /// Runs an async action and maps its [Result] to [ViewState].
  @protected
  Future<void> execute(
    Future<result.Result<T>> Function() action, {
    bool showLoading = true,
    void Function(T data)? onSuccess,
    void Function(String message)? onError,
  }) async {
    if (showLoading) setLoading();

    final actionResult = await action();

    switch (actionResult) {
      case result.Success(:final data):
        setSuccess(data);
        onSuccess?.call(data);
      case result.Error(:final failure):
        setError(failure.message);
        onError?.call(failure.message);
    }
  }
}
