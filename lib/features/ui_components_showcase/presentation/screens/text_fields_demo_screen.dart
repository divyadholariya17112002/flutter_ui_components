import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class TextFieldsDemoScreen extends StatefulWidget {
  const TextFieldsDemoScreen({super.key});

  @override
  State<TextFieldsDemoScreen> createState() => _TextFieldsDemoScreenState();
}

class _TextFieldsDemoScreenState extends State<TextFieldsDemoScreen> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController(text: 'Alex Rivera');

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Text Fields'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Text Field',
            child: AppTextField(
              controller: _nameController,
              label: 'Full name',
              hint: 'Enter your name',
              prefixIcon: Icons.person_outline,
            ),
          ),
          ShowcaseSection(
            title: 'Email Field',
            child: AppTextField(
              controller: _emailController,
              label: 'Email',
              hint: 'you@example.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const ShowcaseSection(
            title: 'Password Field',
            child: AppPasswordField(
              label: 'Password',
              hint: 'Enter password',
            ),
          ),
        ],
      ),
    );
  }
}
