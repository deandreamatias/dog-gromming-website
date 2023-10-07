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
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColors.secondary;
      }
      return AppColors.white;
    }),
    checkColor: MaterialStateProperty.all(AppColors.white),
    side: const BorderSide(color: AppColors.secondary, width: 2),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderTypes.borderRadius4,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderTypes.borderRadius8,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderTypes.borderRadius8,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderTypes.borderRadius8,
      borderSide: BorderSide(color: AppColors.secondary, width: 2),
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
  static const BorderRadius borderRadius4 =
      BorderRadius.all(Radius.circular(4));
  static const BorderRadius borderRadius8 =
      BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderRadius16 =
      BorderRadius.all(Radius.circular(16));
  static const BorderRadius borderRadius32 =
      BorderRadius.all(Radius.circular(32));
  static const BorderRadius borderRadiusTop32 =
      BorderRadius.vertical(top: Radius.circular(32));
}
