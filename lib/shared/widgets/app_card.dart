import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

enum AppCardVariant { elevated, filled, outlined }

/// Base Material 3 card shell used by all reusable card widgets.
class AppCardContainer extends StatelessWidget {
  const AppCardContainer({
    required this.child,
    super.key,
    this.onTap,
    this.padding,
    this.variant = AppCardVariant.elevated,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding ??
          EdgeInsets.all(
            AppResponsive.spacing(context, AppSpacing.md),
          ),
      child: child,
    );

    return switch (variant) {
      AppCardVariant.elevated => Card(
          child: InkWell(
            onTap: onTap,
            child: content,
          ),
        ),
      AppCardVariant.filled => Card.filled(
          child: InkWell(
            onTap: onTap,
            child: content,
          ),
        ),
      AppCardVariant.outlined => Card.outlined(
          child: InkWell(
            onTap: onTap,
            child: content,
          ),
        ),
    };
  }
}

/// Simple content card for generic UI blocks.
class AppSimpleCard extends StatelessWidget {
  const AppSimpleCard({
    required this.child,
    super.key,
    this.title,
    this.subtitle,
    this.onTap,
    this.variant = AppCardVariant.elevated,
  });

  final String? title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onTap;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCardContainer(
      onTap: onTap,
      variant: variant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          if (title != null || subtitle != null) const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Profile summary card with avatar and optional trailing action.
class AppProfileCard extends StatelessWidget {
  const AppProfileCard({
    required this.name,
    required this.role,
    super.key,
    this.subtitle,
    this.avatarImage,
    this.initials,
    this.trailing,
    this.onTap,
    this.variant = AppCardVariant.elevated,
  });

  final String name;
  final String role;
  final String? subtitle;
  final ImageProvider<Object>? avatarImage;
  final String? initials;
  final Widget? trailing;
  final VoidCallback? onTap;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppCardContainer(
      onTap: onTap,
      variant: variant,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: avatarImage,
            backgroundColor: colorScheme.primaryContainer,
            child: avatarImage == null
                ? Text(
                    initials ?? _fallbackInitials(name),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          trailing ?? const SizedBox.shrink(),
        ],
      ),
    );
  }

  String _fallbackInitials(String value) {
    final parts = value.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }
}

/// Product card with image, title, description and price.
class AppProductCard extends StatelessWidget {
  const AppProductCard({
    required this.title,
    required this.price,
    super.key,
    this.description,
    this.image,
    this.onTap,
    this.onPrimaryAction,
    this.primaryActionLabel = 'Add to cart',
    this.variant = AppCardVariant.elevated,
  });

  final String title;
  final String price;
  final String? description;
  final ImageProvider<Object>? image;
  final VoidCallback? onTap;
  final VoidCallback? onPrimaryAction;
  final String primaryActionLabel;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCardContainer(
      onTap: onTap,
      variant: variant,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
              ),
              child: image == null
                  ? Icon(
                      Icons.image_outlined,
                      size: 36,
                      color: theme.colorScheme.onSurfaceVariant,
                    )
                  : Image(
                      image: image!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              AppResponsive.spacing(context, AppSpacing.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      price,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    FilledButton.tonal(
                      onPressed: onPrimaryAction,
                      child: Text(primaryActionLabel),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Image-first card with title and subtitle overlay.
class AppImageCard extends StatelessWidget {
  const AppImageCard({
    required this.title,
    super.key,
    this.subtitle,
    this.image,
    this.height = 180,
    this.onTap,
    this.variant = AppCardVariant.elevated,
  });

  final String title;
  final String? subtitle;
  final ImageProvider<Object>? image;
  final double height;
  final VoidCallback? onTap;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCardContainer(
      onTap: onTap,
      variant: variant,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (image != null)
              Image(image: image!, fit: BoxFit.cover)
            else
              Container(
                color: theme.colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.image_outlined,
                  size: 40,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.05),
                    Colors.black.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                AppResponsive.spacing(context, AppSpacing.md),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dashboard card to display a key metric with icon.
class AppDashboardCard extends StatelessWidget {
  const AppDashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
    this.trend,
    this.onTap,
    this.variant = AppCardVariant.filled,
  });

  final String title;
  final String value;
  final IconData icon;
  final String? trend;
  final VoidCallback? onTap;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppCardContainer(
      onTap: onTap,
      variant: variant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
                child: Icon(icon),
              ),
              const Spacer(),
              if (trend != null)
                Text(
                  trend!,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Statistic card for label/value/change summary.
class AppStatisticCard extends StatelessWidget {
  const AppStatisticCard({
    required this.label,
    required this.value,
    super.key,
    this.changeText,
    this.isPositiveChange = true,
    this.onTap,
    this.variant = AppCardVariant.outlined,
  });

  final String label;
  final String value;
  final String? changeText;
  final bool isPositiveChange;
  final VoidCallback? onTap;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final changeColor = isPositiveChange ? colorScheme.primary : colorScheme.error;

    return AppCardContainer(
      onTap: onTap,
      variant: variant,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (changeText != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  isPositiveChange ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                  size: 18,
                  color: changeColor,
                ),
                const SizedBox(width: 4),
                Text(
                  changeText!,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: changeColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Skeleton loading placeholder card.
class AppLoadingSkeletonCard extends StatelessWidget {
  const AppLoadingSkeletonCard({
    super.key,
    this.lines = 3,
    this.variant = AppCardVariant.elevated,
  });

  final int lines;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final base = colorScheme.surfaceContainerHighest;
    final highlight = colorScheme.surfaceContainerHigh;

    return AppCardContainer(
      variant: variant,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.25, end: 1),
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOut,
        builder: (context, value, _) {
          final lerped = Color.lerp(base, highlight, value) ?? base;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 18,
                width: 120,
                decoration: BoxDecoration(
                  color: lerped,
                  borderRadius: BorderRadius.circular(AppRadius.sm.value),
                ),
              ),
              const SizedBox(height: 12),
              for (var i = 0; i < lines; i++) ...[
                Container(
                  height: 12,
                  width: i == lines - 1 ? 160 : double.infinity,
                  decoration: BoxDecoration(
                    color: lerped.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(AppRadius.sm.value),
                  ),
                ),
                if (i < lines - 1) const SizedBox(height: 8),
              ],
            ],
          );
        },
        onEnd: () {},
      ),
    );
  }
}

/// Responsive card that adapts spacing and optional max width.
class AppResponsiveCard extends StatelessWidget {
  const AppResponsiveCard({
    required this.child,
    super.key,
    this.title,
    this.maxWidth,
    this.center = true,
    this.variant = AppCardVariant.elevated,
  });

  final Widget child;
  final String? title;
  final double? maxWidth;
  final bool center;
  final AppCardVariant variant;

  @override
  Widget build(BuildContext context) {
    final content = LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final padding = width >= AppResponsive.tabletBreakpoint
            ? AppResponsive.spacing(context, AppSpacing.lg)
            : AppResponsive.spacing(context, AppSpacing.md);

        return AppCardContainer(
          variant: variant,
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 12),
              ],
              child,
            ],
          ),
        );
      },
    );

    final widthConstrained = maxWidth == null
        ? content
        : ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth!),
            child: content,
          );

    if (!center) return widthConstrained;
    return Align(
      alignment: Alignment.center,
      child: widthConstrained,
    );
  }
}
