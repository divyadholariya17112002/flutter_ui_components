import 'package:flutter/material.dart';
import 'package:flutter_ui_components/shared/widgets/app_button.dart';
import 'package:flutter_ui_components/shared/widgets/app_state_message.dart';

/// Placeholder for empty lists or empty-state screens.
class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: AppStateMessage(
        icon: icon,
        iconColor: theme.colorScheme.onSurfaceVariant,
        message: message,
        action: actionLabel != null && onAction != null
            ? AppSecondaryButton(
                label: actionLabel!,
                onPressed: onAction,
                expand: false,
              )
            : null,
      ),
    );
  }
}
