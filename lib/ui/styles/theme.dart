import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:dog_gromming_website/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

final themeData = ThemeData(
  colorSchemeSeed: AppColors.primary,
  scaffoldBackgroundColor: AppColors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(AppColors.secondary),
      textStyle: MaterialStateProperty.all(TextStyles.labelLarge),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(56),
        ),
      ),
    ),
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyles.labelLarge,
    labelMedium: TextStyles.labelMedium,
    labelSmall: TextStyles.labelSmall,
    displayLarge: TextStyles.displayLarge,
    displayMedium: TextStyles.displayMedium,
    displaySmall: TextStyles.displaySmall,
    headlineLarge: TextStyles.headlineLarge,
    headlineMedium: TextStyles.headlineMedium,
    headlineSmall: TextStyles.headlineSmall,
    bodyLarge: TextStyles.bodyLarge,
    bodyMedium: TextStyles.bodyMedium,
    bodySmall: TextStyles.bodySmall,
    titleLarge: TextStyles.titleLarge,
    titleMedium: TextStyles.titleMedium,
    titleSmall: TextStyles.titleSmall,
  ),
);

class BorderTypes {
  static const BorderRadius borderRadius8 =
      BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderRadius16 =
      BorderRadius.all(Radius.circular(16));
  static const BorderRadius borderRadius32 =
      BorderRadius.all(Radius.circular(32));
  static const BorderRadius borderRadiusTop32 =
      BorderRadius.vertical(top: Radius.circular(32));
}
