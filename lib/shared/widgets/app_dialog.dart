import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/shared/widgets/app_progress_dialog.dart';

enum AppDialogType { confirmation, success, error, warning }

/// Reusable dialog and picker helpers aligned with app theme.
abstract final class AppDialog {
  static Future<bool> confirmation(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool barrierDismissible = true,
  }) async {
    final result = await _showTypedDialog<bool>(
      context,
      type: AppDialogType.confirmation,
      title: title,
      message: message,
      barrierDismissible: barrierDismissible,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    );

    return result ?? false;
  }

  static Future<void> success(
    BuildContext context, {
    required String title,
    required String message,
    String actionLabel = 'OK',
    bool barrierDismissible = true,
  }) {
    return _showTypedDialog<void>(
      context,
      type: AppDialogType.success,
      title: title,
      message: message,
      barrierDismissible: barrierDismissible,
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(actionLabel),
        ),
      ],
    );
  }

  static Future<void> error(
    BuildContext context, {
    required String title,
    required String message,
    String actionLabel = 'OK',
    bool barrierDismissible = true,
  }) {
    return _showTypedDialog<void>(
      context,
      type: AppDialogType.error,
      title: title,
      message: message,
      barrierDismissible: barrierDismissible,
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(actionLabel),
        ),
      ],
    );
  }

  static Future<void> warning(
    BuildContext context, {
    required String title,
    required String message,
    String actionLabel = 'Understood',
    bool barrierDismissible = true,
  }) {
    return _showTypedDialog<void>(
      context,
      type: AppDialogType.warning,
      title: title,
      message: message,
      barrierDismissible: barrierDismissible,
      actions: [
        FilledButton.tonal(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(actionLabel),
        ),
      ],
    );
  }

  static Future<void> loading(
    BuildContext context, {
    String message = 'Please wait...',
    bool barrierDismissible = false,
  }) {
    return AppProgressDialog.show(
      context,
      message: message,
      barrierDismissible: barrierDismissible,
    );
  }

  static void hideLoading(BuildContext context) {
    AppProgressDialog.hide(context);
  }

  static Future<T?> bottomSheet<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool isScrollControlled = false,
    bool showDragHandle = true,
    bool useSafeArea = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      builder: builder,
    );
  }

  static Future<DateTime?> datePicker(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    String? helpText,
  }) {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(now.year - 100),
      lastDate: lastDate ?? DateTime(now.year + 100),
      helpText: helpText,
    );
  }

  static Future<TimeOfDay?> timePicker(
    BuildContext context, {
    TimeOfDay? initialTime,
    String? helpText,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      helpText: helpText,
    );
  }

  static Future<T?> _showTypedDialog<T>(
    BuildContext context, {
    required AppDialogType type,
    required String title,
    required String message,
    required List<Widget> actions,
    required bool barrierDismissible,
  }) {
    final theme = Theme.of(context);
    final (icon, iconColor) = _iconStyle(theme, type);

    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        final spacing = AppResponsive.spacing(dialogContext, AppSpacing.sm);

        return AlertDialog(
          titlePadding: EdgeInsets.fromLTRB(24, 20, 24, 0),
          contentPadding: EdgeInsets.fromLTRB(24, spacing, 24, 0),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          title: Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          actions: actions,
        );
      },
    );
  }

  static (IconData, Color) _iconStyle(ThemeData theme, AppDialogType type) {
    return switch (type) {
      AppDialogType.confirmation => (
          Icons.help_outline_rounded,
          theme.colorScheme.primary,
        ),
      AppDialogType.success => (
          Icons.check_circle_outline_rounded,
          theme.colorScheme.primary,
        ),
      AppDialogType.error => (
          Icons.error_outline_rounded,
          theme.colorScheme.error,
        ),
      AppDialogType.warning => (
          Icons.warning_amber_rounded,
          theme.colorScheme.tertiary,
        ),
    };
  }
}
