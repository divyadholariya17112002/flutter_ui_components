import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class BottomSheetsDemoScreen extends StatelessWidget {
  const BottomSheetsDemoScreen({super.key});

  Future<void> _showModalSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(
            AppResponsive.spacing(context, AppSpacing.lg),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Modal Bottom Sheet',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 8),
              const Text('Use sheets for quick actions and options.'),
              const SizedBox(height: 16),
              AppPrimaryButton(
                label: 'Close',
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showActionSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.share_outlined),
                title: const Text('Share'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: const Icon(Icons.link_outlined),
                title: const Text('Copy link'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Bottom Sheets'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Modal Sheet',
            child: AppPrimaryButton(
              label: 'Show Modal Bottom Sheet',
              onPressed: () => _showModalSheet(context),
            ),
          ),
          ShowcaseSection(
            title: 'Action Sheet',
            child: AppSecondaryButton(
              label: 'Show Action Bottom Sheet',
              onPressed: () => _showActionSheet(context),
            ),
          ),
        ],
      ),
    );
  }
}
