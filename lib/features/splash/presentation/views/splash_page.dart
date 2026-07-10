import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_components/core/config/app_constants.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/splash/presentation/viewmodels/splash_view_model.dart';
import 'package:flutter_ui_components/features/splash/presentation/widgets/splash_animated_logo.dart';
import 'package:provider/provider.dart';

/// Branded splash screen with theme-aware styling and entry animations.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curve);
    _scaleAnimation = Tween<double>(begin: 0.82, end: 1).animate(curve);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(curve);

    _controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashViewModel>().initialize();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.surface,
                colorScheme.primaryContainer.withValues(alpha: 0.35),
                colorScheme.surfaceContainerHighest,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.spacing(context, AppSpacing.xl),
              ),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: SplashAnimatedLogo(
                        color: colorScheme.primary,
                        backgroundColor: colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppResponsive.spacing(context, AppSpacing.lg),
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Text(
                        AppConstants.appName,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppResponsive.spacing(context, AppSpacing.sm),
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Reusable UI Components Library',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Spacer(flex: 4),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppResponsive.spacing(context, AppSpacing.xl),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
