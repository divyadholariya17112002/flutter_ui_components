import 'package:flutter/material.dart';

/// Reusable text field wired to the app [InputDecorationTheme].
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      autocorrect: false,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

/// Search input with leading search icon and optional clear button.
class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.label = 'Search',
    this.hint = 'Search',
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final hasValue = controller?.text.isNotEmpty ?? false;

    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      enabled: enabled,
      prefixIcon: Icons.search_rounded,
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      suffixIcon: hasValue
          ? IconButton(
              onPressed: enabled
                  ? () {
                      controller?.clear();
                      onChanged?.call('');
                      onClear?.call();
                    }
                  : null,
              icon: const Icon(Icons.close_rounded),
            )
          : null,
    );
  }
}

/// OTP input with fixed-length numeric boxes.
class AppOtpField extends StatefulWidget {
  const AppOtpField({
    super.key,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.enabled = true,
  });

  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool enabled;

  @override
  State<AppOtpField> createState() => _AppOtpFieldState();
}

class _AppOtpFieldState extends State<AppOtpField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleChanged(int index, String value) {
    if (value.length > 1) {
      final first = value.substring(0, 1);
      _controllers[index].text = first;
      _controllers[index].selection = TextSelection.collapsed(offset: first.length);
    }

    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }

    final code = _controllers.map((controller) => controller.text).join();
    widget.onChanged?.call(code);
    final isComplete = _controllers.every((controller) => controller.text.isNotEmpty);
    if (isComplete) {
      widget.onCompleted?.call(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final spacing = 8.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == widget.length - 1 ? 0 : spacing),
            child: TextFormField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              enabled: widget.enabled,
              keyboardType: TextInputType.number,
              textInputAction:
                  index == widget.length - 1 ? TextInputAction.done : TextInputAction.next,
              textAlign: TextAlign.center,
              maxLength: 1,
              onChanged: (value) => _handleChanged(index, value),
              decoration: const InputDecoration(counterText: ''),
            ),
          ),
        );
      }),
    );
  }
}

/// Phone number input preconfigured with phone keyboard and validation.
class AppPhoneNumberField extends StatelessWidget {
  const AppPhoneNumberField({
    super.key,
    this.controller,
    this.label = 'Phone Number',
    this.hint = '+1 555 123 4567',
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  static String? defaultValidator(String? value) {
    final text = value?.trim() ?? '';
    final normalized = text.replaceAll(RegExp(r'[\s\-()]'), '');
    if (normalized.isEmpty) return 'Phone number is required';
    if (!RegExp(r'^\+?[0-9]{8,15}$').hasMatch(normalized)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      enabled: enabled,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.telephoneNumber],
      prefixIcon: Icons.phone_outlined,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator ?? defaultValidator,
    );
  }
}

/// Email input preconfigured with email keyboard and validation.
class AppEmailField extends StatelessWidget {
  const AppEmailField({
    super.key,
    this.controller,
    this.label = 'Email',
    this.hint = 'you@example.com',
    this.enabled = true,
    this.onChanged,
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FormFieldValidator<String>? validator;

  static String? defaultValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      enabled: enabled,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      prefixIcon: Icons.email_outlined,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator ?? defaultValidator,
    );
  }
}

/// Multi-line text input.
class AppMultilineField extends StatelessWidget {
  const AppMultilineField({
    super.key,
    this.controller,
    this.label = 'Description',
    this.hint,
    this.enabled = true,
    this.minLines = 3,
    this.maxLines = 5,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final bool enabled;
  final int minLines;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      textInputAction: TextInputAction.newline,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: true,
      ),
    );
  }
}

/// Read-only field with optional tap callback.
class AppReadOnlyField extends StatelessWidget {
  const AppReadOnlyField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.value,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? value;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
      suffixIcon: suffixIcon,
    );

    if (controller != null) {
      return TextFormField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: decoration,
      );
    }

    return TextFormField(
      initialValue: value,
      readOnly: true,
      onTap: onTap,
      decoration: decoration,
    );
  }
}

/// Generic field for validation demos.
class AppValidationExampleField extends StatelessWidget {
  const AppValidationExampleField({
    super.key,
    this.controller,
    this.label = 'Validation Field',
    this.hint = 'Enter at least 3 characters',
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;

  static String? defaultValidator(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'This field is required';
    if (text.length < 3) return 'Minimum 3 characters required';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      validator: defaultValidator,
    );
  }
}

/// Text field with configurable prefix and suffix icons.
class AppIconTextField extends StatelessWidget {
  const AppIconTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.onChanged,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
