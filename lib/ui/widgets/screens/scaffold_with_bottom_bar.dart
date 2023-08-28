import 'package:dog_gromming_website/ui/navigation/menu_navigation.dart';
import 'package:dog_gromming_website/ui/navigation/routes.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_bottom_bar.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithBottomBar({
    super.key,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppNavigationBottomBar(
        items: MenuNavigation.values
            .map((e) => AppNavigationItem(label: e.label.tr()))
            .toList(),
        selectedIndex: _calculateSelectedIndex(context),
        onItemTapped: (idx) => _onItemTapped(idx, context),
      ),
      body: SafeArea(child: child),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(Routes.home);
      case 1:
        GoRouter.of(context).go(Routes.services);
      case 2:
        GoRouter.of(context).go(Routes.gallery);
      case 3:
        GoRouter.of(context).go(Routes.about);
    }
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(Routes.home)) {
      return 0;
    }
    if (location.startsWith(Routes.services)) {
      return 1;
    }
    if (location.startsWith(Routes.gallery)) {
      return 2;
    }
    if (location.startsWith(Routes.about)) {
      return 2;
    }
    return 0;
  }
}

extension MenuNavigationExtension on MenuNavigation {
  String get label {
    switch (this) {
      case MenuNavigation.home:
        return 'menu.home';
      case MenuNavigation.services:
        return 'menu.services';
      case MenuNavigation.gallery:
        return 'menu.gallery';
      case MenuNavigation.about:
        return 'menu.about';
    }
  }
}
