import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

/// Material 3 [InputDecorationTheme] for text fields and form inputs.
abstract final class AppInputTheme {
  static ThemeData apply(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final radius = AppRadius.md.value;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: colorScheme.outline),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: colorScheme.primary, width: 2),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(color: colorScheme.error),
    );

    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: TextStyle(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
          fontSize: 14,
        ),
        labelStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 14,
        ),
        errorStyle: TextStyle(
          color: colorScheme.error,
          fontSize: 12,
        ),
        prefixIconColor: colorScheme.onSurfaceVariant,
        suffixIconColor: colorScheme.onSurfaceVariant,
        border: border,
        enabledBorder: border,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        disabledBorder: border.copyWith(
          borderSide: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}
