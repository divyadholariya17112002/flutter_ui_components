import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class DialogsDemoScreen extends StatelessWidget {
  const DialogsDemoScreen({super.key});

  Future<void> _showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm action'),
        content: const Text('This dialog uses the shared dialog theme.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Future<void> _showProgress(BuildContext context) async {
    AppProgressDialog.show(context, message: 'Please wait...');
    await Future<void>.delayed(const Duration(seconds: 2));
    if (context.mounted) AppProgressDialog.hide(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Dialogs'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Alert Dialog',
            child: AppPrimaryButton(
              label: 'Show Alert Dialog',
              onPressed: () => _showAlert(context),
            ),
          ),
          ShowcaseSection(
            title: 'Progress Dialog',
            child: AppSecondaryButton(
              label: 'Show Progress Dialog',
              onPressed: () => _showProgress(context),
            ),
          ),
        ],
      ),
    );
  }
}
