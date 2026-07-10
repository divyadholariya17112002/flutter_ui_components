import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

/// Material 3 typography scale with responsive font sizing.
abstract final class AppTypography {
  static const String fontFamily = 'Roboto';

  static TextTheme textTheme({
    required Brightness brightness,
    required BuildContext context,
  }) {
    final color = brightness == Brightness.light
        ? const Color(0xFF1A1C1E)
        : const Color(0xFFECEFF1);
    final muted = brightness == Brightness.light
        ? const Color(0xFF42474E)
        : const Color(0xFFCAC4D0);

    TextStyle base({
      required double size,
      FontWeight weight = FontWeight.w400,
      double height = 1.4,
      double letterSpacing = 0,
      Color? textColor,
    }) {
      return TextStyle(
        fontFamily: fontFamily,
        fontSize: AppResponsive.fontSize(context, size),
        fontWeight: weight,
        height: height,
        letterSpacing: letterSpacing,
        color: textColor ?? color,
      );
    }

    return TextTheme(
      displayLarge: base(
        size: 57,
        weight: FontWeight.w400,
        height: 1.12,
        letterSpacing: -0.25,
      ),
      displayMedium: base(
        size: 45,
        weight: FontWeight.w400,
        height: 1.16,
      ),
      displaySmall: base(
        size: 36,
        weight: FontWeight.w400,
        height: 1.22,
      ),
      headlineLarge: base(
        size: 32,
        weight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.5,
      ),
      headlineMedium: base(
        size: 28,
        weight: FontWeight.w600,
        height: 1.28,
      ),
      headlineSmall: base(
        size: 24,
        weight: FontWeight.w600,
        height: 1.33,
      ),
      titleLarge: base(
        size: 22,
        weight: FontWeight.w600,
        height: 1.27,
      ),
      titleMedium: base(
        size: 16,
        weight: FontWeight.w600,
        height: 1.5,
        letterSpacing: 0.15,
      ),
      titleSmall: base(
        size: 14,
        weight: FontWeight.w600,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      bodyLarge: base(size: 16, height: 1.5, letterSpacing: 0.5),
      bodyMedium: base(size: 14, height: 1.43, letterSpacing: 0.25),
      bodySmall: base(
        size: 12,
        height: 1.33,
        letterSpacing: 0.4,
        textColor: muted,
      ),
      labelLarge: base(
        size: 14,
        weight: FontWeight.w600,
        height: 1.43,
        letterSpacing: 0.1,
      ),
      labelMedium: base(
        size: 12,
        weight: FontWeight.w600,
        height: 1.33,
        letterSpacing: 0.5,
      ),
      labelSmall: base(
        size: 11,
        weight: FontWeight.w600,
        height: 1.45,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Static typography for theme building without [BuildContext].
  static TextTheme staticTextTheme(Brightness brightness) {
    final color = brightness == Brightness.light
        ? const Color(0xFF1A1C1E)
        : const Color(0xFFECEFF1);

    TextStyle style({
      required double size,
      FontWeight weight = FontWeight.w400,
      double height = 1.4,
    }) {
      return TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        fontWeight: weight,
        height: height,
        color: color,
      );
    }

    return TextTheme(
      displayLarge: style(size: 57, height: 1.12),
      displayMedium: style(size: 45, height: 1.16),
      displaySmall: style(size: 36, height: 1.22),
      headlineLarge: style(size: 32, weight: FontWeight.w700, height: 1.25),
      headlineMedium: style(size: 28, weight: FontWeight.w600, height: 1.28),
      headlineSmall: style(size: 24, weight: FontWeight.w600, height: 1.33),
      titleLarge: style(size: 22, weight: FontWeight.w600, height: 1.27),
      titleMedium: style(size: 16, weight: FontWeight.w600, height: 1.5),
      titleSmall: style(size: 14, weight: FontWeight.w600, height: 1.43),
      bodyLarge: style(size: 16, height: 1.5),
      bodyMedium: style(size: 14, height: 1.43),
      bodySmall: style(size: 12, height: 1.33),
      labelLarge: style(size: 14, weight: FontWeight.w600, height: 1.43),
      labelMedium: style(size: 12, weight: FontWeight.w600, height: 1.33),
      labelSmall: style(size: 11, weight: FontWeight.w600, height: 1.45),
    );
  }
}
