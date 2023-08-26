import 'package:dog_gromming_website/ui/styles/sizes.dart';
import 'package:flutter/widgets.dart';

extension ResponsiveSizes on BuildContext {
  Sizes get widthSize {
    final width = MediaQuery.of(this).size.width;
    if (width < Sizes.small.width) {
      return Sizes.small;
    } else if (width < Sizes.medium.width) {
      return Sizes.medium;
    } else if (width < Sizes.large.width) {
      return Sizes.large;
    }
    return Sizes.extraLarge;
  }
}
