import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/box_shadows.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_item.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/label_l_text.dart';
import 'package:flutter/material.dart';

class AppNavigationBottomBar extends StatelessWidget {
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
          children: items.asMap().entries.map(
            (entry) {
              final item = entry.value;
              final itemIndex = entry.key;
              return _AppNavigationItemButton(
                key: Key('bottom-bar-item-$itemIndex'),
                selected: itemIndex == selectedIndex,
                item: item,
                onTap: () => onItemTapped?.call(itemIndex),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

class _AppNavigationItemButton extends StatelessWidget {
  final bool selected;
  final AppNavigationItem item;
  final VoidCallback? onTap;

  const _AppNavigationItemButton({
    required this.selected,
    required this.item,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Insets.a4,
      child: InkWell(
        onTap: Feedback.wrapForTap(onTap, context),
        child: Container(
          padding: Insets.h4 + Insets.a4,
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(Spacing.sp32),
          ),
          child: LabelLText(item.label),
        ),
      ),
    );
  }

  Color? get _bgColor => selected ? AppColors.primary : null;
}
