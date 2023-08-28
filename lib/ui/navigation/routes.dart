import 'package:dog_gromming_website/ui/navigation/menu_navigation.dart';

class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static const String announcement = '/announcement';
  static const String services = '/services';
  static const String about = '/about';
  static const String gallery = '/gallery';
}

extension MenuRoutes on MenuNavigation {
  String get route {
    switch (this) {
      case MenuNavigation.home:
        return Routes.home;
      case MenuNavigation.services:
        return Routes.services;
      case MenuNavigation.gallery:
        return Routes.gallery;
      case MenuNavigation.about:
        return Routes.about;
    }
  }
}
