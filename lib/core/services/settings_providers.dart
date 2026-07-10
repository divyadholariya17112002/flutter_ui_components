import 'package:flutter_ui_components/core/provider/base_provider.dart';
import 'package:flutter_ui_components/core/services/local_storage.dart';
import 'package:flutter_ui_components/core/services/settings_view_model.dart';
import 'package:provider/single_child_widget.dart';

abstract final class SettingsProviders {
  static List<SingleChildWidget> providers({
    required LocalStorage localStorage,
  }) {
    return [
      BaseProvider.viewModel<SettingsViewModel>(
        (context) => SettingsViewModel(localStorage: localStorage),
      ),
    ];
  }
}
