import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';

/// Data model for reusable navigation destinations.
class AppNavDestination {
  const AppNavDestination({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.tooltip,
  });

  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? tooltip;
}

/// Data model for reusable drawer items.
class AppDrawerItem {
  const AppDrawerItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final String? subtitle;
  final Widget? trailing;
}

/// Data model for reusable popup menu actions.
class AppPopupMenuAction<T> {
  const AppPopupMenuAction({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  final T value;
  final String label;
  final IconData? icon;
  final bool enabled;
}

/// Custom app bar with optional leading/actions and Material 3 styling.
class AppCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppCustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.bottom,
    this.systemOverlayStyle,
    this.automaticallyImplyLeading = true,
    this.elevation,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool automaticallyImplyLeading;
  final double? elevation;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(title),
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      bottom: bottom,
      elevation: elevation,
      scrolledUnderElevation: 0,
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      foregroundColor: theme.colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: automaticallyImplyLeading,
      systemOverlayStyle: systemOverlayStyle ??
          (theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light),
    );
  }
}

/// Material 3 bottom navigation wrapper.
class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final List<AppNavDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: destinations
          .map(
            (destination) => NavigationDestination(
              icon: Icon(destination.icon),
              selectedIcon: destination.selectedIcon == null
                  ? null
                  : Icon(destination.selectedIcon),
              label: destination.label,
              tooltip: destination.tooltip,
            ),
          )
          .toList(),
    );
  }
}

/// Material 3 navigation drawer wrapper.
class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({
    super.key,
    required this.items,
    this.header,
    this.footer,
    this.selectedIndex,
  });

  final List<AppDrawerItem> items;
  final Widget? header;
  final Widget? footer;
  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    if (header != null) {
      children.add(header!);
    }
    children.addAll(
      items.map(
        (item) => NavigationDrawerDestination(
          icon: Icon(item.icon),
          label: Text(item.title),
        ),
      ),
    );
    if (footer != null) {
      children
        ..add(const Divider())
        ..add(footer!);
    }

    return NavigationDrawer(
      selectedIndex: selectedIndex,
      children: children,
      onDestinationSelected: (index) => items[index].onTap(),
    );
  }
}

/// Material 3 tab bar shell for reusable tab layouts.
class AppTabScaffold extends StatelessWidget {
  const AppTabScaffold({
    super.key,
    required this.tabs,
    required this.views,
    this.isScrollable = false,
    this.tabAlignment,
    this.dividerColor,
  }) : assert(tabs.length == views.length);

  final List<Tab> tabs;
  final List<Widget> views;
  final bool isScrollable;
  final TabAlignment? tabAlignment;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: isScrollable,
            tabAlignment: tabAlignment,
            dividerColor: dividerColor,
            tabs: tabs,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: AppResponsive.isTabletOrWider(context) ? 240 : 180,
            child: TabBarView(children: views),
          ),
        ],
      ),
    );
  }
}

/// Theme-aligned floating action button.
class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.label,
    this.tooltip,
    this.extended = false,
  });

  final VoidCallback? onPressed;
  final IconData? icon;
  final String? label;
  final String? tooltip;
  final bool extended;

  @override
  Widget build(BuildContext context) {
    final resolvedIcon = icon ?? Icons.add_rounded;

    if (extended) {
      return FloatingActionButton.extended(
        onPressed: onPressed,
        tooltip: tooltip,
        icon: Icon(resolvedIcon),
        label: Text(label ?? 'Add'),
      );
    }

    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: tooltip,
      child: Icon(resolvedIcon),
    );
  }
}

/// Reusable popup menu button with typed actions.
class AppPopupMenuButton<T> extends StatelessWidget {
  const AppPopupMenuButton({
    super.key,
    required this.items,
    required this.onSelected,
    this.icon = Icons.more_vert_rounded,
    this.tooltip,
    this.initialValue,
  });

  final List<AppPopupMenuAction<T>> items;
  final ValueChanged<T> onSelected;
  final IconData icon;
  final String? tooltip;
  final T? initialValue;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      tooltip: tooltip,
      icon: Icon(icon),
      initialValue: initialValue,
      onSelected: onSelected,
      itemBuilder: (context) {
        return items
            .map(
              (item) => PopupMenuItem<T>(
                value: item.value,
                enabled: item.enabled,
                child: Row(
                  children: [
                    if (item.icon != null) ...[
                      Icon(item.icon, size: 20),
                      const SizedBox(width: 10),
                    ],
                    Text(item.label),
                  ],
                ),
              ),
            )
            .toList();
      },
    );
  }
}
