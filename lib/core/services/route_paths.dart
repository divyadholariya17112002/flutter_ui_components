/// Centralized route path constants for [GoRouter].
abstract final class RoutePaths {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String apiList = '/api-list';
  static const String details = '/details';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String components = '/components';
  static const String componentsButtons = '/components/buttons';
  static const String componentsTextFields = '/components/text-fields';
  static const String componentsCards = '/components/cards';
  static const String componentsDialogs = '/components/dialogs';
  static const String componentsBottomSheets = '/components/bottom-sheets';
  static const String componentsLoaders = '/components/loaders';
  static const String componentsSnackbars = '/components/snackbars';
  static const String componentsAppBars = '/components/app-bars';
  static const String componentsChips = '/components/chips';
  static const String componentsAvatars = '/components/avatars';
  static const String componentsListTiles = '/components/list-tiles';
  static const String componentsBadges = '/components/badges';
  static const String componentsProgress = '/components/progress';
  static const String componentsNavigation = '/components/navigation';

  static String itemDetails(String id) => '$details/$id';
}
