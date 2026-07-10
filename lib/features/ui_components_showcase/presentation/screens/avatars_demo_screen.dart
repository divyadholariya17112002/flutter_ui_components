import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class AvatarsDemoScreen extends StatelessWidget {
  const AvatarsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppAppBar(title: 'Avatars'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Initials',
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  foregroundColor: colorScheme.onPrimaryContainer,
                  child: const Text('AR'),
                ),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: colorScheme.secondaryContainer,
                  foregroundColor: colorScheme.onSecondaryContainer,
                  child: const Text('JD'),
                ),
                CircleAvatar(
                  radius: 32,
                  backgroundColor: colorScheme.tertiaryContainer,
                  foregroundColor: colorScheme.onTertiaryContainer,
                  child: const Text('UI'),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Icons',
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
                  child: Icon(Icons.person, color: colorScheme.primary),
                ),
                CircleAvatar(
                  backgroundColor: colorScheme.tertiary.withValues(alpha: 0.15),
                  child: Icon(Icons.groups, color: colorScheme.tertiary),
                ),
                CircleAvatar(
                  backgroundColor: colorScheme.error.withValues(alpha: 0.15),
                  child: Icon(Icons.support_agent, color: colorScheme.error),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Stacked',
            child: SizedBox(
              height: 48,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: CircleAvatar(
                      backgroundColor: colorScheme.primaryContainer,
                      child: const Text('A'),
                    ),
                  ),
                  Positioned(
                    left: 28,
                    child: CircleAvatar(
                      backgroundColor: colorScheme.secondaryContainer,
                      child: const Text('B'),
                    ),
                  ),
                  Positioned(
                    left: 56,
                    child: CircleAvatar(
                      backgroundColor: colorScheme.tertiaryContainer,
                      child: const Text('+3'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
