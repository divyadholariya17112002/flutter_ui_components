import 'package:flutter/material.dart';

/// Breakpoints, spacing, radius, and scaled dimensions.
abstract final class AppResponsive {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;

  static AppBreakpoint breakpointOf(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return AppBreakpoint.desktop;
    if (width >= tabletBreakpoint) return AppBreakpoint.tablet;
    if (width >= mobileBreakpoint) return AppBreakpoint.mobile;
    return AppBreakpoint.compact;
  }

  static bool isCompact(BuildContext context) =>
      breakpointOf(context) == AppBreakpoint.compact;

  static bool isMobileOrWider(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= mobileBreakpoint;

  static bool isTabletOrWider(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      breakpointOf(context) == AppBreakpoint.desktop;

  // Spacing scale
  static double spacing(BuildContext context, AppSpacing size) {
    final scale = _scaleFactor(context);
    return size.value * scale;
  }

  static double radius(BuildContext context, AppRadius size) {
    final scale = _scaleFactor(context);
    return size.value * scale;
  }

  static double fontSize(BuildContext context, double base) {
    return base * _fontScale(context);
  }

  static double buttonHeight(BuildContext context) {
    return switch (breakpointOf(context)) {
      AppBreakpoint.compact => 48,
      AppBreakpoint.mobile => 50,
      AppBreakpoint.tablet => 52,
      AppBreakpoint.desktop => 54,
    };
  }

  static EdgeInsets pagePadding(BuildContext context) {
    final horizontal = switch (breakpointOf(context)) {
      AppBreakpoint.compact => 16.0,
      AppBreakpoint.mobile => 20.0,
      AppBreakpoint.tablet => 32.0,
      AppBreakpoint.desktop => 40.0,
    };

    return EdgeInsets.symmetric(horizontal: horizontal, vertical: 24);
  }

  static double contentMaxWidth(BuildContext context) {
    return switch (breakpointOf(context)) {
      AppBreakpoint.compact => double.infinity,
      AppBreakpoint.mobile => 600,
      AppBreakpoint.tablet => 840,
      AppBreakpoint.desktop => 1200,
    };
  }

  static double _scaleFactor(BuildContext context) {
    return switch (breakpointOf(context)) {
      AppBreakpoint.compact => 1.0,
      AppBreakpoint.mobile => 1.0,
      AppBreakpoint.tablet => 1.05,
      AppBreakpoint.desktop => 1.1,
    };
  }

  static double _fontScale(BuildContext context) {
    final textScaler = MediaQuery.textScalerOf(context);
    final systemScale = textScaler.scale(1);
    final breakpointScale = switch (breakpointOf(context)) {
      AppBreakpoint.compact => 1.0,
      AppBreakpoint.mobile => 1.0,
      AppBreakpoint.tablet => 1.02,
      AppBreakpoint.desktop => 1.04,
    };
    return systemScale * breakpointScale;
  }
}

enum AppBreakpoint { compact, mobile, tablet, desktop }

enum AppSpacing {
  xxs(4),
  xs(8),
  sm(12),
  md(16),
  lg(24),
  xl(32),
  xxl(48);

  const AppSpacing(this.value);
  final double value;
}

enum AppRadius {
  sm(8),
  md(12),
  lg(16),
  xl(20),
  full(999);

  const AppRadius(this.value);
  final double value;
}
