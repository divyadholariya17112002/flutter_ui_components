import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

/// Shared icon + message layout used by error, empty, and banner widgets.
class AppStateMessage extends StatelessWidget {
  const AppStateMessage({
    super.key,
    required this.icon,
    required this.message,
    this.iconColor,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(24),
    this.action,
    this.compact = false,
  });

  final IconData icon;
  final String message;
  final Color? iconColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final Widget? action;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = compact ? 20.0 : 48.0;

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: iconSize,
          color: iconColor ?? theme.colorScheme.error,
        ),
        SizedBox(width: AppResponsive.spacing(context, AppSpacing.sm)),
        Expanded(
          child: Text(
            message,
            style: compact
                ? theme.textTheme.bodyMedium
                : theme.textTheme.bodyMedium?.copyWith(
                    color: iconColor ?? theme.colorScheme.onSurface,
                  ),
            textAlign: compact ? TextAlign.start : TextAlign.center,
          ),
        ),
      ],
    );

    if (backgroundColor != null) {
      return Container(
        width: double.infinity,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            AppResponsive.radius(context, AppRadius.md),
          ),
        ),
        child: content,
      );
    }

    return SingleChildScrollView(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!compact) ...[
            Icon(
              icon,
              size: iconSize,
              color: iconColor ?? theme.colorScheme.error,
            ),
            SizedBox(height: AppResponsive.spacing(context, AppSpacing.md)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
          ] else
            content,
          if (action != null) ...[
            SizedBox(height: AppResponsive.spacing(context, AppSpacing.md)),
            action!,
          ],
        ],
      ),
    );
  }
}
