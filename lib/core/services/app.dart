import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/services/settings_view_model.dart';
import 'package:flutter_ui_components/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsViewModel>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = context.read<GoRouter>();

    return Consumer<SettingsViewModel>(
      builder: (context, settings, _) {
        return MaterialApp.router(
          title: 'Flutter Clean Architecture',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: settings.themeMode,
          routerConfig: router,
        );
      },
    );
  }
}
