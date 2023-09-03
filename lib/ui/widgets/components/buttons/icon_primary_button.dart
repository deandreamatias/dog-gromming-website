import 'package:dog_gromming_website/ui/styles/spacing.dart';
import 'package:flutter/material.dart';

class IconPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final bool isBigButton;
  final String tooltip;

  const IconPrimaryButton({
    super.key,
    required this.onPressed,
    required this.icon,
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
        child: Icon(
          icon,
          size: isBigButton ? 56 : 20,
          // color: AppColors.white,
        ),
      ),
    );
  }
}
