import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/provider/view_model.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/features/authentication/domain/validators/auth_validator.dart';
import 'package:go_router/go_router.dart';

enum RegisterStatus { idle, loading, success, error }

class RegisterViewModel extends ViewModel {
  RegisterViewModel({required GoRouter router}) : _router = router;

  final GoRouter _router;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RegisterStatus _status = RegisterStatus.idle;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _generalError;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  RegisterStatus get status => _status;
  String? get nameError => _nameError;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  String? get confirmPasswordError => _confirmPasswordError;
  String? get generalError => _generalError;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get isLoading => _status == RegisterStatus.loading;
  bool get canSubmit => !isLoading;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  Future<void> register() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirm = confirmPasswordController.text;

    final nameError = AuthValidator.validateName(name);
    final emailError = AuthValidator.validateEmail(email);
    final passwordError = AuthValidator.validatePassword(password);
    final confirmError =
        AuthValidator.validateConfirmPassword(password, confirm);

    if (nameError != null ||
        emailError != null ||
        passwordError != null ||
        confirmError != null) {
      _nameError = nameError;
      _emailError = emailError;
      _passwordError = passwordError;
      _confirmPasswordError = confirmError;
      _status = RegisterStatus.error;
      notifyListeners();
      return;
    }

    _status = RegisterStatus.loading;
    _generalError = null;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 1500));

    _status = RegisterStatus.success;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 600));
    _router.go(RoutePaths.login);
  }

  void goToLogin() => _router.go(RoutePaths.login);

  @override
  void onDispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}
