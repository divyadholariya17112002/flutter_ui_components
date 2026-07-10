import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

/// Reusable loading indicator for full-screen or inline async states.
class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    this.message,
    this.size = 36,
    this.expand = true,
  });

  final String? message;
  final double size;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final indicator = SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(strokeWidth: 3),
    );

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        indicator,
        if (message != null) ...[
          SizedBox(height: AppResponsive.spacing(context, AppSpacing.md)),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ],
    );

    if (!expand) return content;

    return Center(child: content);
  }
}
