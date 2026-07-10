import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class SnackbarsDemoScreen extends StatelessWidget {
  const SnackbarsDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Snackbars'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Success',
            child: AppPrimaryButton(
              label: 'Show Success',
              onPressed: () => AppSnackbar.success(context, 'Saved successfully'),
            ),
          ),
          ShowcaseSection(
            title: 'Error',
            child: AppSecondaryButton(
              label: 'Show Error',
              onPressed: () => AppSnackbar.error(context, 'Something went wrong'),
            ),
          ),
          ShowcaseSection(
            title: 'Info',
            child: AppSecondaryButton(
              label: 'Show Info',
              onPressed: () => AppSnackbar.info(context, 'New update available'),
            ),
          ),
          ShowcaseSection(
            title: 'Warning',
            child: AppSecondaryButton(
              label: 'Show Warning',
              onPressed: () =>
                  AppSnackbar.warning(context, 'Connection is unstable'),
            ),
          ),
          ShowcaseSection(
            title: 'With Action',
            child: AppPrimaryButton(
              label: 'Show With Action',
              onPressed: () => AppSnackbar.show(
                context,
                message: 'Item deleted',
                type: AppSnackbarType.info,
                actionLabel: 'Undo',
                onAction: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
