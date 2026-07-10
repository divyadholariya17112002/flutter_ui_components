import 'package:flutter/material.dart';

/// Brand and semantic color tokens.
///
/// Use [AppColorScheme] for theme-aware [ColorScheme] instances.
abstract final class AppColors {
  // Brand
  static const Color seed = Color(0xFF1565C0);
  static const Color primary = Color(0xFF1565C0);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color secondary = Color(0xFF00897B);
  static const Color tertiary = Color(0xFF6A1B9A);

  // Semantic
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFC62828);
  static const Color info = Color(0xFF0277BD);

  // Light surfaces
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFE8EDF3);
  static const Color lightOutline = Color(0xFFB0BEC5);
  static const Color lightOnSurface = Color(0xFF1A1C1E);

  // Dark surfaces
  static const Color darkBackground = Color(0xFF0F1419);
  static const Color darkSurface = Color(0xFF1A2332);
  static const Color darkSurfaceVariant = Color(0xFF2A3444);
  static const Color darkOutline = Color(0xFF546E7A);
  static const Color darkOnSurface = Color(0xFFECEFF1);
}
