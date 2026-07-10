import 'package:flutter/material.dart';

/// Animated app mark used on the splash screen.
class SplashAnimatedLogo extends StatelessWidget {
  const SplashAnimatedLogo({
    super.key,
    required this.color,
    required this.backgroundColor,
  });

  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 112,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Icon(
        Icons.architecture_rounded,
        size: 56,
        color: color,
      ),
    );
  }
}
