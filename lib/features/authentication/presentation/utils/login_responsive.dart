import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

/// Login-specific responsive helpers built on [AppResponsive].
abstract final class LoginResponsive {
  static double formMaxWidth(BuildContext context) {
    final breakpoint = AppResponsive.breakpointOf(context);
    return switch (breakpoint) {
      AppBreakpoint.desktop => 440,
      AppBreakpoint.tablet => 420,
      AppBreakpoint.mobile => 400,
      AppBreakpoint.compact => double.infinity,
    };
  }

  static EdgeInsets pagePadding(BuildContext context) =>
      AppResponsive.pagePadding(context);

  static bool isWideLayout(BuildContext context) =>
      AppResponsive.isMobileOrWider(context);
}
