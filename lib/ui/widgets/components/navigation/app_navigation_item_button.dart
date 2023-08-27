import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/insets.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/widgets/components/navigation/app_navigation_item.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/label_l_text.dart';
import 'package:flutter/material.dart';

class AppNavigationItemButton extends StatelessWidget {
  final bool selected;
  final AppNavigationItem item;
  final VoidCallback? onTap;

  const AppNavigationItemButton({
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
          padding: Insets.h8 + Insets.a4,
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(Spacing.sp32),
          ),
          child: LabelLText(
            item.label,
            color: _color,
          ),
        ),
      ),
    );
  }

  Color? get _bgColor => selected ? AppColors.primary : null;

  Color get _color =>
      selected ? AppColors.font : AppColors.font.withOpacity(0.87);
}
