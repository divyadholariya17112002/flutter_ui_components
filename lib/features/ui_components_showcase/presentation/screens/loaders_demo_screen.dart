import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class LoadersDemoScreen extends StatelessWidget {
  const LoadersDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Loaders'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          const ShowcaseSection(
            title: 'Loading',
            child: SizedBox(
              height: 140,
              child: Card(
                child: AppLoadingWidget(message: 'Loading data...'),
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Error',
            child: SizedBox(
              height: 160,
              child: Card(
                child: AppErrorWidget(
                  message: 'Unable to load content.',
                  onRetry: () {},
                ),
              ),
            ),
          ),
          const ShowcaseSection(
            title: 'Empty',
            child: SizedBox(
              height: 140,
              child: Card(
                child: AppEmptyWidget(message: 'No items to display.'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
