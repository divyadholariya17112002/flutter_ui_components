import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/authentication/presentation/viewmodels/register_view_model.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const AppAppBar(title: 'Create Account'),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.secondaryContainer.withValues(alpha: 0.32),
              colorScheme.surface,
              colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Consumer<RegisterViewModel>(
                  builder: (context, viewModel, _) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(
                          AppResponsive.spacing(context, AppSpacing.lg),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Register',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: AppResponsive.spacing(context, AppSpacing.lg),
                            ),
                            if (viewModel.generalError != null) ...[
                              AppInlineErrorBanner(
                                message: viewModel.generalError!,
                              ),
                              SizedBox(
                                height: AppResponsive.spacing(context, AppSpacing.md),
                              ),
                            ],
                            AppTextField(
                              controller: viewModel.nameController,
                              label: 'Name',
                              hint: 'John Doe',
                              errorText: viewModel.nameError,
                              enabled: viewModel.canSubmit,
                              prefixIcon: Icons.person_outline,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: AppResponsive.spacing(context, AppSpacing.md),
                            ),
                            AppTextField(
                              controller: viewModel.emailController,
                              label: 'Email',
                              hint: 'you@example.com',
                              errorText: viewModel.emailError,
                              enabled: viewModel.canSubmit,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email_outlined,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: AppResponsive.spacing(context, AppSpacing.md),
                            ),
                            AppPasswordField(
                              controller: viewModel.passwordController,
                              label: 'Password',
                              errorText: viewModel.passwordError,
                              enabled: viewModel.canSubmit,
                              obscureText: viewModel.obscurePassword,
                              onToggleVisibility:
                                  viewModel.togglePasswordVisibility,
                            ),
                            SizedBox(
                              height: AppResponsive.spacing(context, AppSpacing.md),
                            ),
                            AppPasswordField(
                              controller: viewModel.confirmPasswordController,
                              label: 'Confirm Password',
                              errorText: viewModel.confirmPasswordError,
                              enabled: viewModel.canSubmit,
                              obscureText: viewModel.obscureConfirmPassword,
                              onToggleVisibility:
                                  viewModel.toggleConfirmPasswordVisibility,
                            ),
                            SizedBox(
                              height: AppResponsive.spacing(context, AppSpacing.lg),
                            ),
                            AppPrimaryButton(
                              label: 'Register',
                              isLoading: viewModel.isLoading,
                              onPressed: viewModel.register,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account?',
                                  style: theme.textTheme.bodyMedium,
                                ),
                                TextButton(
                                  onPressed: () => context.go(RoutePaths.login),
                                  child: const Text('Sign In'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
