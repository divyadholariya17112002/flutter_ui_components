import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/provider/provider.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/core/services/settings_view_model.dart';
import 'package:flutter_ui_components/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter_ui_components/features/profile/presentation/viewmodels/profile_view_model.dart';
import 'package:flutter_ui_components/features/profile/presentation/widgets/profile_header_widget.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Profile'),
      body: Consumer<ProfileViewModel>(
        builder: (context, viewModel, _) {
          return ViewStateBuilder<ProfileEntity>(
            state: viewModel.state,
            onRetry: viewModel.loadProfile,
            onSuccess: (context, profile) => Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  ProfileHeaderWidget(profile: profile),
                  const SizedBox(height: 24),
                  Card(
                    child: Column(
                      children: [
                        Consumer<SettingsViewModel>(
                          builder: (context, settings, _) {
                            return SwitchListTile(
                              title: const Text('Dark Mode'),
                              subtitle: const Text('Toggle app theme'),
                              value: settings.isDarkMode,
                              onChanged: settings.toggleDarkMode,
                            );
                          },
                        ),
                        const Divider(height: 1),
                        ListTile(
                          leading: const Icon(Icons.settings_outlined),
                          title: const Text('Settings'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => context.push(RoutePaths.settings),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  AppSecondaryButton(
                    label: 'Logout',
                    onPressed: viewModel.logout,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
