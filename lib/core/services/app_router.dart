import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/features/authentication/presentation/views/forgot_password_page.dart';
import 'package:flutter_ui_components/features/authentication/presentation/views/login_page.dart';
import 'package:flutter_ui_components/features/authentication/presentation/views/register_page.dart';
import 'package:flutter_ui_components/features/home/domain/entities/home_item_entity.dart';
import 'package:flutter_ui_components/features/home/presentation/views/api_list_page.dart';
import 'package:flutter_ui_components/features/home/presentation/views/home_page.dart';
import 'package:flutter_ui_components/features/home/presentation/views/item_details_page.dart';
import 'package:flutter_ui_components/features/profile/presentation/views/profile_page.dart';
import 'package:flutter_ui_components/features/settings/presentation/views/settings_page.dart';
import 'package:flutter_ui_components/features/splash/di/splash_providers.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/app_bars_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/avatars_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/badges_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/bottom_sheets_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/buttons_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/cards_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/chips_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/dialogs_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/list_tiles_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/loaders_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/navigation_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/progress_indicators_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/snackbars_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/text_fields_demo_screen.dart';
import 'package:flutter_ui_components/features/ui_components_showcase/presentation/screens/ui_showcase_home_screen.dart';
import 'package:go_router/go_router.dart';

/// Application router configuration.
class AppRouter {
  AppRouter._();

  static GoRouter create() {
    return GoRouter(
      initialLocation: RoutePaths.splash,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: RoutePaths.splash,
          name: 'splash',
          builder: (context, state) => SplashProviders.page(),
        ),
        GoRoute(
          path: RoutePaths.login,
          name: 'login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: RoutePaths.register,
          name: 'register',
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: RoutePaths.forgotPassword,
          name: 'forgot-password',
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: RoutePaths.home,
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: RoutePaths.apiList,
          name: 'api-list',
          builder: (context, state) => const ApiListPage(),
        ),
        GoRoute(
          path: '${RoutePaths.details}/:id',
          name: 'details',
          builder: (context, state) {
            final item = state.extra as HomeItemEntity?;
            if (item != null) {
              return ItemDetailsPage(item: item);
            }

            return ItemDetailsPage(
              item: HomeItemEntity(
                id: state.pathParameters['id'] ?? '0',
                title: 'Unknown Item',
                subtitle: 'Not found',
                description: 'Item details were not passed to this route.',
              ),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.profile,
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: RoutePaths.settings,
          name: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
        GoRoute(
          path: RoutePaths.components,
          name: 'components',
          builder: (context, state) => const UiShowcaseHomeScreen(),
          routes: [
            GoRoute(
              path: 'buttons',
              name: 'components-buttons',
              builder: (context, state) => const ButtonsDemoScreen(),
            ),
            GoRoute(
              path: 'text-fields',
              name: 'components-text-fields',
              builder: (context, state) => const TextFieldsDemoScreen(),
            ),
            GoRoute(
              path: 'cards',
              name: 'components-cards',
              builder: (context, state) => const CardsDemoScreen(),
            ),
            GoRoute(
              path: 'dialogs',
              name: 'components-dialogs',
              builder: (context, state) => const DialogsDemoScreen(),
            ),
            GoRoute(
              path: 'bottom-sheets',
              name: 'components-bottom-sheets',
              builder: (context, state) => const BottomSheetsDemoScreen(),
            ),
            GoRoute(
              path: 'loaders',
              name: 'components-loaders',
              builder: (context, state) => const LoadersDemoScreen(),
            ),
            GoRoute(
              path: 'snackbars',
              name: 'components-snackbars',
              builder: (context, state) => const SnackbarsDemoScreen(),
            ),
            GoRoute(
              path: 'app-bars',
              name: 'components-app-bars',
              builder: (context, state) => const AppBarsDemoScreen(),
            ),
            GoRoute(
              path: 'chips',
              name: 'components-chips',
              builder: (context, state) => const ChipsDemoScreen(),
            ),
            GoRoute(
              path: 'avatars',
              name: 'components-avatars',
              builder: (context, state) => const AvatarsDemoScreen(),
            ),
            GoRoute(
              path: 'list-tiles',
              name: 'components-list-tiles',
              builder: (context, state) => const ListTilesDemoScreen(),
            ),
            GoRoute(
              path: 'badges',
              name: 'components-badges',
              builder: (context, state) => const BadgesDemoScreen(),
            ),
            GoRoute(
              path: 'progress',
              name: 'components-progress',
              builder: (context, state) => const ProgressIndicatorsDemoScreen(),
            ),
            GoRoute(
              path: 'navigation',
              name: 'components-navigation',
              builder: (context, state) => const NavigationDemoScreen(),
            ),
          ],
        ),
      ],
    );
  }
}
