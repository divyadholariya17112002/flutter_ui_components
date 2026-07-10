import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/provider/view_model.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/features/authentication/domain/validators/auth_validator.dart';
import 'package:go_router/go_router.dart';

enum ForgotPasswordStatus { idle, loading, success, error }

class ForgotPasswordViewModel extends ViewModel {
  ForgotPasswordViewModel({required GoRouter router}) : _router = router;

  final GoRouter _router;
  final emailController = TextEditingController();

  ForgotPasswordStatus _status = ForgotPasswordStatus.idle;
  String? _emailError;
  String? _message;

  ForgotPasswordStatus get status => _status;
  String? get emailError => _emailError;
  String? get message => _message;
  bool get isLoading => _status == ForgotPasswordStatus.loading;
  bool get isSuccess => _status == ForgotPasswordStatus.success;

  void onEmailChanged(String value) {
    _emailError = null;
    _message = null;
    _status = ForgotPasswordStatus.idle;
    notifyListeners();
  }

  Future<void> sendResetLink() async {
    final emailError = AuthValidator.validateEmail(emailController.text);
    if (emailError != null) {
      _emailError = emailError;
      _status = ForgotPasswordStatus.error;
      notifyListeners();
      return;
    }

    _status = ForgotPasswordStatus.loading;
    _emailError = null;
    _message = null;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 1200));

    _status = ForgotPasswordStatus.success;
    _message =
        'Reset link sent to ${emailController.text.trim()}. Check your inbox.';
    notifyListeners();
  }

  void goToLogin() => _router.go(RoutePaths.login);

  @override
  void onDispose() {
    emailController.dispose();
  }
}
