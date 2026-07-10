import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

enum AppSnackbarType { success, error, info, warning }

/// Centralized snackbar helper — consistent styling across the app.
abstract final class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    AppSnackbarType type = AppSnackbarType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final theme = Theme.of(context);
    final (icon, background, foreground) = _style(theme, type);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: duration,
          backgroundColor: background,
          content: Row(
            children: [
              Icon(icon, color: foreground, size: 20),
              SizedBox(width: AppResponsive.spacing(context, AppSpacing.sm)),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: foreground,
                  ),
                ),
              ),
            ],
          ),
          action: actionLabel != null && onAction != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: foreground,
                  onPressed: onAction,
                )
              : null,
        ),
      );
  }

  static void success(BuildContext context, String message) =>
      show(context, message: message, type: AppSnackbarType.success);

  static void error(BuildContext context, String message) =>
      show(context, message: message, type: AppSnackbarType.error);

  static void info(BuildContext context, String message) =>
      show(context, message: message, type: AppSnackbarType.info);

  static void warning(BuildContext context, String message) =>
      show(context, message: message, type: AppSnackbarType.warning);

  static (IconData, Color, Color) _style(ThemeData theme, AppSnackbarType type) {
    return switch (type) {
      AppSnackbarType.success => (
          Icons.check_circle_outline,
          theme.colorScheme.primary,
          theme.colorScheme.onPrimary,
        ),
      AppSnackbarType.error => (
          Icons.error_outline,
          theme.colorScheme.error,
          theme.colorScheme.onError,
        ),
      AppSnackbarType.warning => (
          Icons.warning_amber_rounded,
          theme.colorScheme.tertiaryContainer,
          theme.colorScheme.onTertiaryContainer,
        ),
      AppSnackbarType.info => (
          Icons.info_outline,
          theme.colorScheme.inverseSurface,
          theme.colorScheme.onInverseSurface,
        ),
    };
  }
}
