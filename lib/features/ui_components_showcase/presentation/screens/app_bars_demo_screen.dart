import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class AppBarsDemoScreen extends StatelessWidget {
  const AppBarsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppAppBar(title: 'App Bars'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Default App Bar',
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: AppAppBar(
                title: 'Default',
                automaticallyImplyLeading: false,
              ),
            ),
          ),
          ShowcaseSection(
            title: 'With Actions',
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: AppAppBar(
                title: 'With Actions',
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'With Tabs',
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: DefaultTabController(
                length: 3,
                child: AppAppBar(
                  title: 'With Tabs',
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    labelColor: colorScheme.primary,
                    tabs: const [
                      Tab(text: 'One'),
                      Tab(text: 'Two'),
                      Tab(text: 'Three'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
