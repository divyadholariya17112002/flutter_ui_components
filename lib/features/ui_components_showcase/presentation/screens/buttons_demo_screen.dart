import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class ButtonsDemoScreen extends StatefulWidget {
  const ButtonsDemoScreen({super.key});

  @override
  State<ButtonsDemoScreen> createState() => _ButtonsDemoScreenState();
}

class _ButtonsDemoScreenState extends State<ButtonsDemoScreen> {
  var _isLoading = false;

  Future<void> _simulateLoading() async {
    setState(() => _isLoading = true);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Buttons'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Primary',
            child: AppPrimaryButton(
              label: 'Primary Button',
              onPressed: () {},
            ),
          ),
          ShowcaseSection(
            title: 'Secondary',
            child: AppSecondaryButton(
              label: 'Secondary Button',
              onPressed: () {},
            ),
          ),
          ShowcaseSection(
            title: 'With Icon',
            child: AppPrimaryButton(
              label: 'Continue',
              icon: Icons.arrow_forward_rounded,
              onPressed: () {},
            ),
          ),
          ShowcaseSection(
            title: 'Loading',
            child: AppPrimaryButton(
              label: 'Submit',
              isLoading: _isLoading,
              onPressed: _simulateLoading,
            ),
          ),
          ShowcaseSection(
            title: 'Inline (non-expanding)',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                AppPrimaryButton(
                  label: 'Save',
                  expand: false,
                  onPressed: () {},
                ),
                AppSecondaryButton(
                  label: 'Cancel',
                  expand: false,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
