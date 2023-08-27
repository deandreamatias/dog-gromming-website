import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/box_shadows.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_item.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_item_button.dart';
import 'package:flutter/material.dart';

class AppNavigationBottomBar extends StatefulWidget {
  final List<AppNavigationItem> items;
  final int selectedIndex;
  final Function(int idx)? onItemTapped;

  const AppNavigationBottomBar({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onItemTapped,
  });

  @override
  State<AppNavigationBottomBar> createState() => _AppNavigationBottomBarState();
}

class _AppNavigationBottomBarState extends State<AppNavigationBottomBar> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: BoxShadows.bs1,
      ),
      child: Padding(
        padding: Insets.a4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widget.items.asMap().entries.map(
            (entry) {
              final item = entry.value;
              final itemIndex = entry.key;
              return ValueListenableBuilder(
                valueListenable: _selectedIndex,
                builder: (context, value, child) {
                  return AppNavigationItemButton(
                    key: Key('bottom-bar-item-$itemIndex'),
                    selected: itemIndex == value,
                    item: item,
                    onTap: () {
                      _selectedIndex.value = itemIndex;
                      widget.onItemTapped?.call(itemIndex);
                    },
                  );
                },
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
