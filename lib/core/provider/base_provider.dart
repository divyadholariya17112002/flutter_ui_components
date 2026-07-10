import 'package:flutter/widgets.dart';
import 'package:flutter_ui_components/core/provider/view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

typedef ViewModelFactory<T extends ViewModel> = T Function(BuildContext context);

/// Reusable Provider factories for dependency injection.
abstract final class BaseProvider {
  BaseProvider._();

  /// Registers a lazy singleton service resolved from [BuildContext].
  static SingleChildWidget singleton<T>(
    T Function(BuildContext context) create,
  ) =>
      Provider<T>(create: create);

  /// Registers a pre-built instance.
  static SingleChildWidget value<T>(T instance) =>
      Provider<T>.value(value: instance);

  /// Registers a [ViewModel] backed by [ChangeNotifierProvider].
  static SingleChildWidget viewModel<T extends ViewModel>(
    ViewModelFactory<T> create, {
    bool lazy = true,
  }) =>
      ChangeNotifierProvider<T>(
        lazy: lazy,
        create: create,
      );
}
