import 'package:flutter/material.dart';
import 'package:flutter_ui_components/shared/widgets/app_button.dart';
import 'package:flutter_ui_components/shared/widgets/app_state_message.dart';

/// Full-screen or centered error state with optional retry action.
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel = 'Retry',
  });

  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: AppStateMessage(
        icon: Icons.error_outline_rounded,
        iconColor: theme.colorScheme.error,
        message: message,
        action: onRetry == null
            ? null
            : AppPrimaryButton(
                label: retryLabel,
                onPressed: onRetry,
                expand: false,
              ),
      ),
    );
  }
}

/// Compact inline banner for forms and cards.
class AppInlineErrorBanner extends StatelessWidget {
  const AppInlineErrorBanner({
    super.key,
    required this.message,
    this.isSuccess = false,
  });

  final String message;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = isSuccess
        ? (
            background: theme.colorScheme.primaryContainer,
            foreground: theme.colorScheme.onPrimaryContainer,
            icon: Icons.check_circle_outline_rounded,
          )
        : (
            background: theme.colorScheme.errorContainer,
            foreground: theme.colorScheme.onErrorContainer,
            icon: Icons.error_outline_rounded,
          );

    return AppStateMessage(
      compact: true,
      icon: colors.icon,
      iconColor: colors.foreground,
      backgroundColor: colors.background,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      message: message,
    );
  }
}
