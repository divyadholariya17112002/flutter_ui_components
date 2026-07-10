import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_colors.dart';

/// Light and dark [ColorScheme] definitions for Material 3.
abstract final class AppColorScheme {
  static ColorScheme get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      error: AppColors.error,
      surface: AppColors.lightSurface,
    );

    return scheme.copyWith(
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.lightOnSurface,
      onSurfaceVariant: const Color(0xFF42474E),
      outline: AppColors.lightOutline,
      outlineVariant: const Color(0xFFCAC4D0),
      surfaceContainerLowest: AppColors.lightBackground,
      surfaceContainerLow: const Color(0xFFF3F6FA),
      surfaceContainer: AppColors.lightSurfaceVariant,
      surfaceContainerHigh: const Color(0xFFE2E8F0),
      surfaceContainerHighest: const Color(0xFFD5DEE8),
    );
  }

  static ColorScheme get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: Brightness.dark,
      primary: const Color(0xFF90CAF9),
      secondary: const Color(0xFF4DB6AC),
      tertiary: const Color(0xFFCE93D8),
      error: const Color(0xFFEF9A9A),
      surface: AppColors.darkSurface,
    );

    return scheme.copyWith(
      onPrimary: const Color(0xFF003258),
      onSecondary: const Color(0xFF003731),
      onSurface: AppColors.darkOnSurface,
      onSurfaceVariant: const Color(0xFFCAC4D0),
      outline: AppColors.darkOutline,
      outlineVariant: const Color(0xFF49454F),
      surfaceContainerLowest: AppColors.darkBackground,
      surfaceContainerLow: const Color(0xFF151D29),
      surfaceContainer: AppColors.darkSurfaceVariant,
      surfaceContainerHigh: const Color(0xFF323D4F),
      surfaceContainerHighest: const Color(0xFF3D4A5E),
    );
  }
}
