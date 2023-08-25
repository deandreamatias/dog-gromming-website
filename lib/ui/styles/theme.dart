import 'package:dog_gromming_website/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = ThemeData(
  colorSchemeSeed: AppColors.primary,
  scaffoldBackgroundColor: AppColors.white,
  textTheme: TextTheme(
    labelLarge: GoogleFonts.fredokaTextTheme().bodyLarge,
    labelMedium: GoogleFonts.comfortaaTextTheme().bodyMedium,
  ),
);
