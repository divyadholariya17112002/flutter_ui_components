import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

enum _AppButtonVariant { primary, secondary, outlined, text }

enum AppButtonSize { small, medium, large }

/// Internal shared button implementation — do not use directly.
class _AppButtonCore extends StatelessWidget {
  const _AppButtonCore({
    required this.label,
    required this.onPressed,
    required this.variant,
    this.isLoading = false,
    this.isSuccess = false,
    this.successLabel,
    this.icon,
    this.expand = true,
    this.size = AppButtonSize.medium,
    this.forceDisabled = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final _AppButtonVariant variant;
  final bool isLoading;
  final bool isSuccess;
  final String? successLabel;
  final IconData? icon;
  final bool expand;
  final AppButtonSize size;
  final bool forceDisabled;

  bool get _isDisabled => forceDisabled || isLoading || isSuccess || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final height = _heightFor(context);
    final child = _buildChild(context);

    final button = switch (variant) {
      _AppButtonVariant.primary => FilledButton(
          onPressed: _isDisabled ? null : onPressed,
          child: child,
        ),
      _AppButtonVariant.secondary => OutlinedButton(
          onPressed: _isDisabled ? null : onPressed,
          child: child,
        ),
      _AppButtonVariant.outlined => OutlinedButton(
          onPressed: _isDisabled ? null : onPressed,
          child: child,
        ),
      _AppButtonVariant.text => TextButton(
          onPressed: _isDisabled ? null : onPressed,
          child: child,
        ),
    };

    if (!expand) return button;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: button,
    );
  }

  double _heightFor(BuildContext context) {
    final base = AppResponsive.buttonHeight(context);
    return switch (size) {
      AppButtonSize.small => base - 8,
      AppButtonSize.medium => base,
      AppButtonSize.large => base + 8,
    };
  }

  Widget _buildChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        key: const ValueKey('loading'),
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          color: variant == _AppButtonVariant.primary
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
        ),
      );
    }

    final displayLabel = isSuccess ? (successLabel ?? label) : label;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Row(
        key: ValueKey(isSuccess ? 'success' : 'label'),
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSuccess)
            const Icon(Icons.check_rounded, size: 20)
          else if (icon != null)
            Icon(icon, size: 20),
          if (isSuccess || icon != null)
            const SizedBox(width: 8),
          Text(displayLabel),
        ],
      ),
    );
  }
}

/// Primary filled action button with optional loading and success states.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isSuccess = false,
    this.successLabel,
    this.icon,
    this.expand = true,
    this.size = AppButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isSuccess;
  final String? successLabel;
  final IconData? icon;
  final bool expand;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    return _AppButtonCore(
      label: label,
      onPressed: onPressed,
      variant: _AppButtonVariant.primary,
      isLoading: isLoading,
      isSuccess: isSuccess,
      successLabel: successLabel,
      icon: icon,
      expand: expand,
      size: size,
    );
  }
}

/// Secondary outlined action button with optional loading state.
class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.expand = true,
    this.size = AppButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool expand;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    return _AppButtonCore(
      label: label,
      onPressed: onPressed,
      variant: _AppButtonVariant.secondary,
      isLoading: isLoading,
      icon: icon,
      expand: expand,
      size: size,
    );
  }
}

/// Explicit outlined action button.
class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.expand = true,
    this.size = AppButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool expand;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    return _AppButtonCore(
      label: label,
      onPressed: onPressed,
      variant: _AppButtonVariant.outlined,
      isLoading: isLoading,
      icon: icon,
      expand: expand,
      size: size,
    );
  }
}

/// Text style action button.
class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
    this.size = AppButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    return _AppButtonCore(
      label: label,
      onPressed: onPressed,
      variant: _AppButtonVariant.text,
      icon: icon,
      expand: expand,
      size: size,
    );
  }
}

/// Filled loading action button.
class AppLoadingButton extends StatelessWidget {
  const AppLoadingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = true,
    this.expand = true,
    this.size = AppButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool expand;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    return _AppButtonCore(
      label: label,
      onPressed: onPressed,
      variant: _AppButtonVariant.primary,
      isLoading: isLoading,
      expand: expand,
      size: size,
    );
  }
}

/// Theme-aware icon button.
class AppIconActionButton extends StatelessWidget {
  const AppIconActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.isFilled = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon),
      style: isFilled
          ? IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            )
          : null,
    );
  }
}

/// Disabled button example component.
class AppDisabledButton extends StatelessWidget {
  const AppDisabledButton({
    super.key,
    this.label = 'Disabled',
    this.expand = true,
    this.size = AppButtonSize.medium,
  });

  final String label;
  final bool expand;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    return _AppButtonCore(
      label: label,
      onPressed: null,
      variant: _AppButtonVariant.primary,
      expand: expand,
      size: size,
      forceDisabled: true,
    );
  }
}

/// Convenience small filled button.
class AppSmallButton extends StatelessWidget {
  const AppSmallButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      expand: expand,
      size: AppButtonSize.small,
    );
  }
}

/// Convenience large filled button.
class AppLargeButton extends StatelessWidget {
  const AppLargeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      label: label,
      onPressed: onPressed,
      icon: icon,
      expand: expand,
      size: AppButtonSize.large,
    );
  }
}
