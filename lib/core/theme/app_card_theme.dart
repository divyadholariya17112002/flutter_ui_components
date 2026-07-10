import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

/// Material 3 [CardThemeData] configuration.
abstract final class AppCardTheme {
  static ThemeData apply(ThemeData theme) {
    final colorScheme = theme.colorScheme;

    return theme.copyWith(
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surface,
        surfaceTintColor: colorScheme.surfaceTint,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg.value),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.6),
          ),
        ),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
