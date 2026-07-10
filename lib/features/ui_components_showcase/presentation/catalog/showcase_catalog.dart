import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';

/// Static catalog of reusable UI component categories for the showcase.
class ShowcaseCategory {
  const ShowcaseCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
}

abstract final class ShowcaseCatalog {
  static const List<ShowcaseCategory> categories = [
    ShowcaseCategory(
      title: 'Buttons',
      subtitle: 'Primary, secondary, and loading states',
      icon: Icons.smart_button_outlined,
      route: RoutePaths.componentsButtons,
    ),
    ShowcaseCategory(
      title: 'Text Fields',
      subtitle: 'Text and password inputs',
      icon: Icons.text_fields_outlined,
      route: RoutePaths.componentsTextFields,
    ),
    ShowcaseCategory(
      title: 'Cards',
      subtitle: 'Surface cards and list content',
      icon: Icons.credit_card_outlined,
      route: RoutePaths.componentsCards,
    ),
    ShowcaseCategory(
      title: 'Dialogs',
      subtitle: 'Alerts and progress dialogs',
      icon: Icons.chat_bubble_outline,
      route: RoutePaths.componentsDialogs,
    ),
    ShowcaseCategory(
      title: 'Bottom Sheets',
      subtitle: 'Modal and persistent sheets',
      icon: Icons.vertical_align_bottom_outlined,
      route: RoutePaths.componentsBottomSheets,
    ),
    ShowcaseCategory(
      title: 'Loaders',
      subtitle: 'Loading and empty/error states',
      icon: Icons.hourglass_empty_outlined,
      route: RoutePaths.componentsLoaders,
    ),
    ShowcaseCategory(
      title: 'Snackbars',
      subtitle: 'Success, error, info, and warning',
      icon: Icons.notifications_outlined,
      route: RoutePaths.componentsSnackbars,
    ),
    ShowcaseCategory(
      title: 'App Bars',
      subtitle: 'Titles, actions, and tabs',
      icon: Icons.web_asset_outlined,
      route: RoutePaths.componentsAppBars,
    ),
    ShowcaseCategory(
      title: 'Chips',
      subtitle: 'Filter, choice, and input chips',
      icon: Icons.label_outline,
      route: RoutePaths.componentsChips,
    ),
    ShowcaseCategory(
      title: 'Avatars',
      subtitle: 'Image, icon, and initial avatars',
      icon: Icons.account_circle_outlined,
      route: RoutePaths.componentsAvatars,
    ),
    ShowcaseCategory(
      title: 'List Tiles',
      subtitle: 'Standard and switch tiles',
      icon: Icons.view_list_outlined,
      route: RoutePaths.componentsListTiles,
    ),
    ShowcaseCategory(
      title: 'Badges',
      subtitle: 'Notification and count badges',
      icon: Icons.mark_unread_chat_alt_outlined,
      route: RoutePaths.componentsBadges,
    ),
    ShowcaseCategory(
      title: 'Progress Indicators',
      subtitle: 'Linear and circular progress',
      icon: Icons.donut_large_outlined,
      route: RoutePaths.componentsProgress,
    ),
    ShowcaseCategory(
      title: 'Navigation',
      subtitle: 'Bottom bar and tabs',
      icon: Icons.navigation_outlined,
      route: RoutePaths.componentsNavigation,
    ),
  ];
}
