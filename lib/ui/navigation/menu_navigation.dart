import 'package:dog_gromming_website/ui/navigation/routes.dart';
import 'package:dog_gromming_website/ui/widgets/screens/about/about_screen.dart';
import 'package:dog_gromming_website/ui/widgets/screens/gallery/gallery_screen.dart';
import 'package:dog_gromming_website/ui/widgets/screens/home/home_screen.dart';
import 'package:dog_gromming_website/ui/widgets/screens/scaffold_with_nav_bar.dart';
import 'package:dog_gromming_website/ui/widgets/screens/services/services_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _menuNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'menu');

final menuNavigation = ShellRoute(
  navigatorKey: _menuNavigatorKey,
  builder: (BuildContext context, GoRouterState state, Widget child) {
    return ScaffoldWithNavBar(child: child);
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
        return const ServicesScreen();
      },
    ),
    GoRoute(
      path: Routes.gallery,
      builder: (BuildContext context, GoRouterState state) {
        return const GalleryScreen();
      },
    ),
    GoRoute(
      path: Routes.about,
      builder: (BuildContext context, GoRouterState state) {
        return const AboutScreen();
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
