import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';

/// Constants for the fonts used in the app.
class Fonts {}

class TextStyles {
  static const TextStyle defaultText = TextStyle(
      // fontFamily: Fonts.arial,
      );

  static const TextStyle linkText = TextStyle(
    color: AppColors.primaryAccent,
    decoration: TextDecoration.underline,
  );
  static const TextStyle errorMessage = TextStyle(
    color: AppColors.errorBackground,
  );

  static const TextStyle onButton = TextStyle(
    color: AppColors.white,
    fontSize: 16,
  );
}
