/// Shared form validators for authentication flows.
abstract final class AuthValidator {
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? validateName(String value) {
    final name = value.trim();
    if (name.isEmpty) return 'Name is required';
    if (name.length < 2) return 'Name must be at least 2 characters';
    return null;
  }

  static String? validateEmail(String value) {
    final email = value.trim();
    if (email.isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  static String? validateConfirmPassword(String password, String confirm) {
    if (confirm.isEmpty) return 'Please confirm your password';
    if (password != confirm) return 'Passwords do not match';
    return null;
  }
}
