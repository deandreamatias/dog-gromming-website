import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:dog_gromming_website/ui/utils/responsive_sizes.dart';
import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  final String label;
  const DisplayText(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.textThemeDisplay,
      textAlign: TextAlign.center,
    );
  }
}

extension ResponsiveSizes on BuildContext {
  TextStyle? get textThemeDisplay {
    switch (widthSize) {
      case Sizes.medium:
        return Theme.of(this).textTheme.displayMedium;
      case Sizes.large:
      case Sizes.extraLarge:
        return Theme.of(this).textTheme.displayLarge;
      case Sizes.small:
      default:
        return Theme.of(this).textTheme.displaySmall;
    }
  }
}
