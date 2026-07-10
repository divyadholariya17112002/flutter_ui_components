import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class ChipsDemoScreen extends StatefulWidget {
  const ChipsDemoScreen({super.key});

  @override
  State<ChipsDemoScreen> createState() => _ChipsDemoScreenState();
}

class _ChipsDemoScreenState extends State<ChipsDemoScreen> {
  var _selectedFilter = 'All';
  final _selectedChoices = <String>{'Flutter'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Chips'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Filter Chips',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final label in ['All', 'Active', 'Archived'])
                  FilterChip(
                    label: Text(label),
                    selected: _selectedFilter == label,
                    onSelected: (_) => setState(() => _selectedFilter = label),
                  ),
              ],
            ),
          ),
          ShowcaseSection(
            title: 'Choice Chips',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final label in ['Flutter', 'Dart', 'UI'])
                  FilterChip(
                    label: Text(label),
                    selected: _selectedChoices.contains(label),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedChoices.add(label);
                        } else {
                          _selectedChoices.remove(label);
                        }
                      });
                    },
                  ),
              ],
            ),
          ),
          const ShowcaseSection(
            title: 'Assist Chips',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(avatar: Icon(Icons.person_outline, size: 18), label: Text('Alex')),
                Chip(avatar: Icon(Icons.tag, size: 18), label: Text('Design')),
                Chip(label: Text('Reusable')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
