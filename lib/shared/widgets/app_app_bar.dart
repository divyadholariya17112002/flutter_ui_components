import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Consistent application [AppBar] with optional back button and actions.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.onBack,
    this.elevation,
    this.bottom,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final VoidCallback? onBack;
  final double? elevation;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      elevation: elevation,
      scrolledUnderElevation: 0,
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      foregroundColor: theme.colorScheme.onSurface,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: theme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      automaticallyImplyLeading:
          leading == null && automaticallyImplyLeading,
      leading: leading ??
          (onBack != null
              ? IconButton(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                )
              : null),
      actions: actions,
      bottom: bottom,
    );
  }
}
