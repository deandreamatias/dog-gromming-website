import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/widgets/components/assets/svg_icon.dart';
import 'package:flutter/material.dart';

class IconPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconName;
  final bool isBigButton;
  final String tooltip;

  const IconPrimaryButton({
    super.key,
    required this.onPressed,
    required this.iconName,
    this.isBigButton = false,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: isBigButton ? Spacing.sp24 : Spacing.sp12,
            vertical: isBigButton ? Spacing.sp16 : Spacing.sp8,
          ),
        ),
        child: SvgIcon(
          iconName: iconName,
          width: isBigButton ? 56 : 20,
          height: isBigButton ? 56 : 20,
          color: AppColors.white,
        ),
      ),
    );
  }
}
