import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/catalog/showcase_catalog.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_category_tile.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';

/// Home screen listing categorized reusable UI components.
class UiShowcaseHomeScreen extends StatelessWidget {
  const UiShowcaseHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categories = ShowcaseCatalog.categories;

    return Scaffold(
      appBar: const AppAppBar(title: 'UI Components Showcase'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          Text(
            'Reusable Components',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: AppResponsive.spacing(context, AppSpacing.xs)),
          Text(
            'Browse categories and open interactive demos.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: AppResponsive.spacing(context, AppSpacing.lg)),
          ...categories.map(
            (category) => Padding(
              padding: EdgeInsets.only(
                bottom: AppResponsive.spacing(context, AppSpacing.sm),
              ),
              child: ShowcaseCategoryTile(
                category: category,
                onTap: () => context.push(category.route),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
