import 'package:dog_gromming_website/ui/navigation/routes.dart';
import 'package:dog_gromming_website/ui/widgets/screens/announcement/announcement_screen.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/home_screen.dart';
import 'package:dog_gromming_website/ui/widgets/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class MainNavigator {
  final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splash,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.splash,
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: Routes.announcement,
        builder: (BuildContext context, GoRouterState state) =>
            const AnnouncementScreen(),
      ),
    ],
  );

  Future<void> navigateToSplash() {
    return router.push(Routes.splash);
  }

  Future<void> navigateToHome() {
    return router.push(Routes.home);
  }

  Future<void> navigateToAnnouncement() {
    return router.push(Routes.announcement);
  }

  void pop() {
    if (router.canPop()) router.pop();
  }
}
