import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class BadgesDemoScreen extends StatelessWidget {
  const BadgesDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppAppBar(title: 'Badges'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Count Badges',
            child: Wrap(
              spacing: 24,
              runSpacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Badge(
                  label: const Text('3'),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: colorScheme.onSurface,
                  ),
                ),
                Badge(
                  label: const Text('12'),
                  child: Icon(
                    Icons.mail_outline,
                    color: colorScheme.onSurface,
                  ),
                ),
                Badge(
                  label: const Text('99+'),
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Dot Badge',
            child: Badge(
              smallSize: 8,
              child: Icon(
                Icons.account_circle_outlined,
                size: 32,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          ShowcaseSection(
            title: 'On Button',
            child: Badge(
              label: const Text('New'),
              child: AppPrimaryButton(
                label: 'Inbox',
                expand: false,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
