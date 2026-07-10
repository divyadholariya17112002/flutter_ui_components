import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/provider/view_state.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

/// Renders UI from a [ViewState] without duplicating switch logic in pages.
class ViewStateBuilder<T> extends StatelessWidget {
  const ViewStateBuilder({
    super.key,
    required this.state,
    required this.onSuccess,
    this.onLoading,
    this.onError,
    this.onIdle,
    this.onRetry,
  });

  final ViewState<T> state;
  final Widget Function(BuildContext context, T data) onSuccess;
  final Widget Function(BuildContext context)? onLoading;
  final Widget Function(
    BuildContext context,
    String message,
    VoidCallback? onRetry,
  )? onError;
  final Widget Function(BuildContext context)? onIdle;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      Loading<T>() =>
        onLoading?.call(context) ?? const AppLoadingWidget(),
      ViewError<T>(:final message) =>
        onError?.call(context, message, onRetry) ??
            AppErrorWidget(message: message, onRetry: onRetry),
      Success<T>(:final data) => onSuccess(context, data),
      Idle<T>() => onIdle?.call(context) ?? const SizedBox.shrink(),
    };
  }
}
