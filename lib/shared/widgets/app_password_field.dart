import 'package:flutter/material.dart';
import 'package:flutter_ui_components/shared/widgets/app_text_field.dart';

/// Password input with visibility toggle built on [AppTextField].
class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    this.controller,
    this.label = 'Password',
    this.hint,
    this.errorText,
    this.enabled = true,
    this.obscureText,
    this.onChanged,
    this.onSubmitted,
    this.onToggleVisibility,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool enabled;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmitted;
  final VoidCallback? onToggleVisibility;
  final FormFieldValidator<String>? validator;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _internalObscure = true;

  bool get _isObscured => widget.obscureText ?? _internalObscure;

  void _toggle() {
    if (widget.obscureText != null) {
      widget.onToggleVisibility?.call();
    } else {
      setState(() => _internalObscure = !_internalObscure);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      errorText: widget.errorText,
      enabled: widget.enabled,
      obscureText: _isObscured,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted == null
          ? null
          : (_) => widget.onSubmitted!(),
      validator: widget.validator,
      prefixIcon: Icons.lock_outline_rounded,
      suffixIcon: IconButton(
        onPressed: widget.enabled ? _toggle : null,
        icon: Icon(
          _isObscured
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
      ),
    );
  }
}
