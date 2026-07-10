import 'package:flutter/material.dart';

/// Modal progress dialog for blocking async operations.
abstract final class AppProgressDialog {
  static bool _isShowing = false;

  static Future<void> show(
    BuildContext context, {
    String message = 'Please wait...',
    bool barrierDismissible = false,
  }) async {
    if (_isShowing) return;
    _isShowing = true;

    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        final theme = Theme.of(dialogContext);

        return PopScope(
          canPop: barrierDismissible,
          child: AlertDialog(
            backgroundColor: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );
      },
    );

    _isShowing = false;
  }

  static void hide(BuildContext context) {
    if (!_isShowing) return;
    final navigator = Navigator.of(context, rootNavigator: true);
    if (navigator.canPop()) {
      navigator.pop();
    }
    _isShowing = false;
  }
}
