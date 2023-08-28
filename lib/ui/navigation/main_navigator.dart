import 'package:dog_gromming_website/ui/navigation/menu_navigation.dart';
import 'package:dog_gromming_website/ui/navigation/routes.dart';
import 'package:dog_gromming_website/ui/widgets/screens/announcement/announcement_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class MainNavigator {
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.home,
    redirect: (context, state) {
      FlutterNativeSplash.remove();
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: Routes.announcement,
        builder: (BuildContext context, GoRouterState state) =>
            const AnnouncementScreen(),
      ),
      menuNavigation,
    ],
  );
}
