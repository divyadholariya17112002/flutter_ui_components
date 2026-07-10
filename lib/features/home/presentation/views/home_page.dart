import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/config/app_constants.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/home/presentation/widgets/home_navigation_card.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppAppBar(
        title: AppConstants.appName,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => context.push(RoutePaths.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.85, end: 1),
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) => Opacity(
              opacity: value,
              child: Transform.scale(scale: value, child: child),
            ),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(
                  AppResponsive.spacing(context, AppSpacing.lg),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(
                        Icons.dashboard_customize_outlined,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'UI Components Library',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Build screens faster using reusable widgets.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: AppResponsive.spacing(context, AppSpacing.lg)),
          Text(
            'Explore',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppResponsive.spacing(context, AppSpacing.md)),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 20, end: 0),
            duration: const Duration(milliseconds: 550),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) => Transform.translate(
              offset: Offset(0, value),
              child: child,
            ),
            child: GridView.count(
              crossAxisCount: AppResponsive.isCompact(context) ? 2 : 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: [
                HomeNavigationCard(
                  icon: Icons.widgets_outlined,
                  title: 'Components',
                  subtitle: 'All reusable UI demo screens',
                  color: colorScheme.primary,
                  onTap: () => context.push(RoutePaths.components),
                ),
                HomeNavigationCard(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  subtitle: 'View account and preferences',
                  color: colorScheme.secondary,
                  onTap: () => context.push(RoutePaths.profile),
                ),
                HomeNavigationCard(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  subtitle: 'Theme and app customization',
                  color: colorScheme.tertiary,
                  onTap: () => context.push(RoutePaths.settings),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
