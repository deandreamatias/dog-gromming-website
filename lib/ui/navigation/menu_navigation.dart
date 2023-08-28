import 'package:dog_gromming_website/ui/navigation/routes.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/home_screen.dart';
import 'package:dog_gromming_website/ui/widgets/screens/scaffold_with_bottom_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _menuNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'menu');

final menuNavigation = ShellRoute(
  navigatorKey: _menuNavigatorKey,
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return ScaffoldWithBottomBar(child: child);
  },
  routes: <RouteBase>[
    GoRoute(
      path: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: Routes.services,
      builder: (BuildContext context, GoRouterState state) {
        return const Text('Services');
      },
    ),
    GoRoute(
      path: Routes.gallery,
      builder: (BuildContext context, GoRouterState state) {
        return const Text('Gallery');
      },
    ),
    GoRoute(
      path: Routes.about,
      builder: (BuildContext context, GoRouterState state) {
        return const Text('about');
      },
    ),
  ],
);

enum MenuNavigation {
  home,
  services,
  gallery,
  about,
}
