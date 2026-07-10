import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/authentication/data/datasources/fake_auth_remote_data_source.dart';
import 'package:flutter_ui_components/features/authentication/presentation/state/login_state.dart';
import 'package:flutter_ui_components/features/authentication/presentation/viewmodels/login_view_model.dart';
import 'package:flutter_ui_components/features/authentication/presentation/widgets/login_header.dart';
import 'package:flutter_ui_components/features/authentication/presentation/widgets/login_remember_me_tile.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';

class LoginFormCard extends StatelessWidget {
  const LoginFormCard({
    super.key,
    required this.state,
    required this.viewModel,
  });

  final LoginState state;
  final LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final enabled = state.canSubmit;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            const SizedBox(height: 28),
            if (state.generalError != null) ...[
              AppInlineErrorBanner(message: state.generalError!),
              SizedBox(height: AppResponsive.spacing(context, AppSpacing.md)),
            ],
            AppTextField(
              controller: viewModel.emailController,
              label: 'Email',
              hint: 'admin@example.com',
              errorText: state.emailError,
              enabled: enabled,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              prefixIcon: Icons.email_outlined,
              onChanged: viewModel.onEmailChanged,
            ),
            SizedBox(height: AppResponsive.spacing(context, AppSpacing.md)),
            AppPasswordField(
              controller: viewModel.passwordController,
              hint: 'Password@123',
              errorText: state.passwordError,
              enabled: enabled,
              obscureText: state.obscurePassword,
              onChanged: viewModel.onPasswordChanged,
              onToggleVisibility: viewModel.togglePasswordVisibility,
              onSubmitted: viewModel.submit,
            ),
            const SizedBox(height: 4),
            LoginRememberMeTile(
              value: state.rememberMe,
              enabled: enabled,
              onChanged: viewModel.onRememberMeChanged,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: enabled
                    ? () => context.push(RoutePaths.forgotPassword)
                    : null,
                child: const Text('Forgot Password?'),
              ),
            ),
            SizedBox(height: AppResponsive.spacing(context, AppSpacing.md)),
            AppPrimaryButton(
              label: 'Sign In',
              successLabel: 'Success',
              isLoading: state.isLoading,
              isSuccess: state.isSuccess,
              onPressed: viewModel.submit,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: theme.textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: enabled
                      ? () => context.push(RoutePaths.register)
                      : null,
                  child: const Text('Register'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(
                AppResponsive.spacing(context, AppSpacing.sm),
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(
                  AppResponsive.radius(context, AppRadius.md),
                ),
              ),
              child: Text(
                'Demo credentials\n'
                '${FakeAuthRemoteDataSource.demoEmail}\n'
                '${FakeAuthRemoteDataSource.demoPassword}',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
