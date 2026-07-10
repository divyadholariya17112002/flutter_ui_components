import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/authentication/presentation/viewmodels/forgot_password_view_model.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: const AppAppBar(title: 'Forgot Password'),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.tertiaryContainer.withValues(alpha: 0.30),
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
                child: Consumer<ForgotPasswordViewModel>(
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
                              'Reset your password',
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Enter your email and we will send you a reset link.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(
                              height: AppResponsive.spacing(context, AppSpacing.lg),
                            ),
                            if (viewModel.message != null) ...[
                              AppInlineErrorBanner(
                                message: viewModel.message!,
                                isSuccess: viewModel.isSuccess,
                              ),
                              SizedBox(
                                height: AppResponsive.spacing(context, AppSpacing.md),
                              ),
                            ],
                            AppTextField(
                              controller: viewModel.emailController,
                              label: 'Email',
                              hint: 'you@example.com',
                              errorText: viewModel.emailError,
                              enabled: !viewModel.isLoading,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.email_outlined,
                              onChanged: viewModel.onEmailChanged,
                            ),
                            SizedBox(
                              height: AppResponsive.spacing(context, AppSpacing.lg),
                            ),
                            AppPrimaryButton(
                              label: 'Send Reset Link',
                              isLoading: viewModel.isLoading,
                              isSuccess: viewModel.isSuccess,
                              successLabel: 'Sent',
                              onPressed: viewModel.sendResetLink,
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () => context.go(RoutePaths.login),
                              child: const Text('Back to Login'),
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
