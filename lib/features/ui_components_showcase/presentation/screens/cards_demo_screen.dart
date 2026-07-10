import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class CardsDemoScreen extends StatelessWidget {
  const CardsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const AppAppBar(title: 'Cards'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Basic Card',
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(
                  AppResponsive.spacing(context, AppSpacing.md),
                ),
                child: Text(
                  'A simple surface card using the app card theme.',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          ShowcaseSection(
            title: 'List Tile Card',
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(Icons.widgets, color: colorScheme.primary),
                ),
                title: const Text('Component Card'),
                subtitle: const Text('Common pattern for navigable rows'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Outlined Content Card',
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(
                  AppResponsive.spacing(context, AppSpacing.md),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Design Tokens',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Cards inherit radius, elevation, and color from AppTheme.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
