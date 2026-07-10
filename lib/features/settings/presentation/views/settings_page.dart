import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/config/app_constants.dart';
import 'package:flutter_ui_components/core/services/settings_view_model.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const AppAppBar(title: 'Settings'),
      body: Consumer<SettingsViewModel>(
        builder: (context, settings, _) {
          return ListView(
            padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
            children: [
              Text(
                'Appearance',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text('Dark Mode'),
                      subtitle: const Text('Toggle light and dark theme'),
                      value: settings.isDarkMode,
                      onChanged: settings.toggleDarkMode,
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('Theme'),
                      subtitle: Text(_themeLabel(settings.themeMode)),
                      trailing: DropdownButton<ThemeMode>(
                        value: settings.themeMode,
                        underline: const SizedBox.shrink(),
                        items: const [
                          DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text('System'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text('Light'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text('Dark'),
                          ),
                        ],
                        onChanged: (mode) {
                          if (mode != null) settings.setThemeMode(mode);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppResponsive.spacing(context, AppSpacing.lg)),
              Text(
                'Preferences',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Language'),
                      subtitle: const Text('App display language'),
                      trailing: DropdownButton<String>(
                        value: settings.language,
                        underline: const SizedBox.shrink(),
                        items: const [
                          DropdownMenuItem(value: 'en', child: Text('English')),
                          DropdownMenuItem(value: 'hi', child: Text('Hindi')),
                          DropdownMenuItem(value: 'es', child: Text('Spanish')),
                        ],
                        onChanged: (value) {
                          if (value != null) settings.setLanguage(value);
                        },
                      ),
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      title: const Text('Notifications'),
                      subtitle: const Text('Enable push notifications'),
                      value: settings.notificationsEnabled,
                      onChanged: settings.setNotificationsEnabled,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppResponsive.spacing(context, AppSpacing.lg)),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('About'),
                  subtitle: Text(AppConstants.appName),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => showAboutDialog(
                    context: context,
                    applicationName: AppConstants.appName,
                    applicationVersion: '1.0.0',
                    applicationLegalese: '© 2026 Divya M. Dholariya',
                    children: const [
                      SizedBox(height: 12),
                      Text(
                        'Production-ready Flutter scaffold with Clean Architecture, '
                        'MVVM, Provider, and feature-first structure.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _themeLabel(ThemeMode mode) => switch (mode) {
        ThemeMode.system => 'Follow system setting',
        ThemeMode.light => 'Always light',
        ThemeMode.dark => 'Always dark',
      };
}
