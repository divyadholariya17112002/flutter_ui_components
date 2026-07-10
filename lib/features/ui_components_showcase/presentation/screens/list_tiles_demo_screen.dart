import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class ListTilesDemoScreen extends StatefulWidget {
  const ListTilesDemoScreen({super.key});

  @override
  State<ListTilesDemoScreen> createState() => _ListTilesDemoScreenState();
}

class _ListTilesDemoScreenState extends State<ListTilesDemoScreen> {
  var _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppAppBar(title: 'List Tiles'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Standard',
            child: Card(
              child: ListTile(
                leading: Icon(Icons.person_outline, color: colorScheme.primary),
                title: const Text('Profile'),
                subtitle: const Text('View and edit your details'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Switch Tile',
            child: Card(
              child: SwitchListTile(
                secondary: const Icon(Icons.notifications_outlined),
                title: const Text('Notifications'),
                subtitle: const Text('Receive push notifications'),
                value: _notificationsEnabled,
                onChanged: (value) =>
                    setState(() => _notificationsEnabled = value),
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Checkbox Tile',
            child: Card(
              child: CheckboxListTile(
                secondary: const Icon(Icons.lock_outline),
                title: const Text('Remember me'),
                subtitle: const Text('Keep me signed in on this device'),
                value: true,
                onChanged: (_) {},
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
