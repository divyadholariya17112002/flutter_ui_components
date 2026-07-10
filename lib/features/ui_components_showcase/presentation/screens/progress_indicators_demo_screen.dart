import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class ProgressIndicatorsDemoScreen extends StatelessWidget {
  const ProgressIndicatorsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Progress Indicators'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          const ShowcaseSection(
            title: 'Circular',
            child: Center(child: CircularProgressIndicator()),
          ),
          ShowcaseSection(
            title: 'Linear Determinate',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LinearProgressIndicator(value: 0.35),
                SizedBox(height: AppResponsive.spacing(context, AppSpacing.sm)),
                const LinearProgressIndicator(value: 0.7),
                SizedBox(height: AppResponsive.spacing(context, AppSpacing.sm)),
                const LinearProgressIndicator(value: 1),
              ],
            ),
          ),
          const ShowcaseSection(
            title: 'Linear Indeterminate',
            child: LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
