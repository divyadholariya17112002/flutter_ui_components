import 'package:flutter/material.dart';

class LoginRememberMeTile extends StatelessWidget {
  const LoginRememberMeTile({
    super.key,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: enabled ? (checked) => onChanged(checked ?? false) : null,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: const Text('Remember me'),
      subtitle: Text(
        'Save email for next sign in',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
