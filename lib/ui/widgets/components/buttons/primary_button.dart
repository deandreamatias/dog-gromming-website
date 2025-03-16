import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:dog_gromming_website/ui/widgets/components/assets/svg_icon.dart';
import 'package:dog_gromming_website/ui/widgets/components/box_spacer.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/display_s_text.dart';
import 'package:dog_gromming_website/ui/widgets/components/texts/label_l_text.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isBigButton;
  final String iconName; // Add an optional icon parameter

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isBigButton = false,
    this.iconName = '', // Initialize the icon parameter
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: isBigButton ? Spacing.sp24 : Spacing.sp16,
          vertical: isBigButton ? Spacing.sp16 : Spacing.sp8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isBigButton
              ? DisplaySText(
                  label,
                  color: AppColors.white,
                )
              : LabelLText(
                  label,
                  color: AppColors.white,
                ),
          if (iconName.isNotEmpty) ...[
            BoxSpacer.h8(), // Add spacing between label and icon
            SvgIcon(
              iconName: iconName,
              width: isBigButton ? 56 : 20,
              height: isBigButton ? 56 : 20,
              color: AppColors.white,
            ),
          ],
        ],
      ),
    );
  }
}
