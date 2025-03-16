import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';

class BoxShadows {
  static final List<BoxShadow> bs1 = [
    BoxShadow(
      color: AppColors.black.withValues(alpha: 0.12),
      blurRadius: 12,
      offset: const Offset(2, 2),
    ),
  ];
}
