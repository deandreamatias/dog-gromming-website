import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_item.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_item_button.dart';
import 'package:flutter/material.dart';

class AppNavigationTopBar extends StatelessWidget {
  final List<AppNavigationItem> items;
  final int selectedIndex;
  final Function(int idx)? onItemTapped;

  const AppNavigationTopBar({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Padding(
        padding: Insets.a12,
        child: Column(
          children: items.asMap().entries.map(
            (entry) {
              final item = entry.value;
              final idx = entry.key;
              return AppNavigationItemButton(
                key: Key('bottom-bar-item-$idx'),
                selected: idx == selectedIndex,
                item: item,
                onTap: () => onItemTapped?.call(idx),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
