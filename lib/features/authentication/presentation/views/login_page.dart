import 'package:flutter/material.dart';
import 'package:flutter_ui_components/features/authentication/presentation/utils/login_responsive.dart';
import 'package:flutter_ui_components/features/authentication/presentation/viewmodels/login_view_model.dart';
import 'package:flutter_ui_components/features/authentication/presentation/widgets/login_form_card.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primaryContainer.withValues(alpha: 0.42),
              theme.colorScheme.secondaryContainer.withValues(alpha: 0.18),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: LoginResponsive.pagePadding(context),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: LoginResponsive.formMaxWidth(context),
                ),
                child: Consumer<LoginViewModel>(
                  builder: (context, viewModel, _) {
                    return LoginFormCard(
                      state: viewModel.state,
                      viewModel: viewModel,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
