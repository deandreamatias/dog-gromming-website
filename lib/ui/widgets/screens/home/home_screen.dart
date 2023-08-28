import 'package:dog_gromming_website/ui/navigation/menu_navigation.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_bottom_bar.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_item.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/display_m_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppNavigationBottomBar(
        items: MenuNavigation.values
            .where((element) => element != MenuNavigation.home)
            .map(
              (e) => AppNavigationItem(
                label: e.label.tr(),
              ),
            )
            .toList(),
        onItemTapped: (idx) => _selectedIndex.value = idx,
      ),
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (context, value, child) {
              return IndexedStack(
                index: value,
                children: [
                  DisplayMText(value.toString()),
                  DisplayMText(value.toString()),
                  DisplayMText(value.toString()),
                  DisplayMText(value.toString()),
                ],
              );
            },
          ),
        ),
      ),
    );
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
