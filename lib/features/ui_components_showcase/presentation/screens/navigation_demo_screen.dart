import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/widgets/showcase_section.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class NavigationDemoScreen extends StatefulWidget {
  const NavigationDemoScreen({super.key});

  @override
  State<NavigationDemoScreen> createState() => _NavigationDemoScreenState();
}

class _NavigationDemoScreenState extends State<NavigationDemoScreen> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'Navigation'),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          ShowcaseSection(
            title: 'Bottom Navigation Bar',
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: NavigationBar(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() => _selectedIndex = index);
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search_outlined),
                    selectedIcon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
          ShowcaseSection(
            title: 'Tab Bar',
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Overview'),
                        Tab(text: 'Details'),
                        Tab(text: 'Activity'),
                      ],
                    ),
                    SizedBox(
                      height: 120,
                      child: TabBarView(
                        children: [
                          Center(child: Text('Overview tab')),
                          Center(child: Text('Details tab')),
                          Center(child: Text('Activity tab')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
