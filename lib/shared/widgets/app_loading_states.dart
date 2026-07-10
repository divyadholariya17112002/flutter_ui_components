import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/shared/widgets/app_button.dart';
import 'package:flutter_ui_components/shared/widgets/app_state_message.dart';

/// Reusable circular loader with optional label.
class AppCircularLoader extends StatelessWidget {
  const AppCircularLoader({
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
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(strokeWidth: 3),
        ),
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

    return expand ? Center(child: content) : content;
  }
}

/// Reusable linear loader with optional progress and label.
class AppLinearLoader extends StatelessWidget {
  const AppLinearLoader({
    super.key,
    this.message,
    this.value,
    this.expand = true,
  });

  final String? message;
  final double? value;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LinearProgressIndicator(value: value),
        if (message != null) ...[
          SizedBox(height: AppResponsive.spacing(context, AppSpacing.sm)),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ],
    );

    return expand ? Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 320), child: content)) : content;
  }
}

/// Lightweight shimmer loader card for list/item placeholders.
class AppShimmerLoader extends StatefulWidget {
  const AppShimmerLoader({
    super.key,
    this.height = 88,
    this.borderRadius = 16,
  });

  final double height;
  final double borderRadius;

  @override
  State<AppShimmerLoader> createState() => _AppShimmerLoaderState();
}

class _AppShimmerLoaderState extends State<AppShimmerLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = scheme.surfaceContainerHighest;
    final highlight = scheme.surfaceContainerHigh;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final color = Color.lerp(base, highlight, t) ?? base;

        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.85),
                color,
                color.withValues(alpha: 0.9),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Empty state widget.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: AppStateMessage(
        icon: icon,
        iconColor: theme.colorScheme.onSurfaceVariant,
        message: message,
        action: actionLabel != null && onAction != null
            ? AppSecondaryButton(
                label: actionLabel!,
                onPressed: onAction,
                expand: false,
              )
            : null,
      ),
    );
  }
}

/// Error state widget.
class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.message,
    this.retryLabel = 'Retry',
    this.onRetry,
  });

  final String message;
  final String retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: AppStateMessage(
        icon: Icons.error_outline_rounded,
        iconColor: theme.colorScheme.error,
        message: message,
        action: onRetry == null
            ? null
            : AppPrimaryButton(
                label: retryLabel,
                onPressed: onRetry,
                expand: false,
              ),
      ),
    );
  }
}

/// Offline / no-internet state widget.
class AppNoInternetWidget extends StatelessWidget {
  const AppNoInternetWidget({
    super.key,
    this.message = 'No internet connection. Check your network and try again.',
    this.retryLabel = 'Try Again',
    this.onRetry,
  });

  final String message;
  final String retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppStateMessage(
        icon: Icons.wifi_off_rounded,
        message: message,
        iconColor: Theme.of(context).colorScheme.tertiary,
        action: onRetry == null
            ? null
            : AppOutlinedButton(
                label: retryLabel,
                onPressed: onRetry,
                expand: false,
              ),
      ),
    );
  }
}

/// Small reusable retry widget for inline or page usage.
class AppRetryWidget extends StatelessWidget {
  const AppRetryWidget({
    super.key,
    required this.onRetry,
    this.message = 'Something went wrong.',
    this.buttonLabel = 'Retry',
    this.compact = false,
  });

  final VoidCallback onRetry;
  final String message;
  final String buttonLabel;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final content = AppStateMessage(
      compact: compact,
      icon: Icons.refresh_rounded,
      iconColor: Theme.of(context).colorScheme.primary,
      message: message,
      action: AppPrimaryButton(
        label: buttonLabel,
        onPressed: onRetry,
        expand: false,
        size: compact ? AppButtonSize.small : AppButtonSize.medium,
      ),
    );

    return compact ? content : Center(child: content);
  }
}

/// Responsive state container that adapts max width + padding.
class AppResponsiveState extends StatelessWidget {
  const AppResponsiveState({
    super.key,
    required this.child,
    this.maxWidth,
  });

  final Widget child;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final resolvedMaxWidth = maxWidth ?? AppResponsive.contentMaxWidth(context);
    final horizontal = AppResponsive.spacing(context, AppSpacing.md);
    final vertical = AppResponsive.spacing(context, AppSpacing.lg);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: resolvedMaxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: child,
        ),
      ),
    );
  }
}
