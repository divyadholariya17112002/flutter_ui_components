import 'package:flutter/material.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/catalog/showcase_catalog.dart';

class ShowcaseCategoryTile extends StatelessWidget {
  const ShowcaseCategoryTile({
    required this.category,
    required this.onTap,
    super.key,
  });

  final ShowcaseCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(category.icon, color: colorScheme.primary),
        ),
        title: Text(
          category.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(category.subtitle),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
