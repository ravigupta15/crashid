import 'package:flutter/material.dart';
import 'package:crashid/res/app_colors.dart';

const String fontFamily = "Outfit";

TextTheme appTextTheme(TextTheme base, Brightness brightness) {
  return base.copyWith(
    bodyMedium: base.bodyMedium?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.bodyMedium,
    ),
    titleMedium: base.titleMedium?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.titleMedium,
    ),
    labelMedium: base.labelMedium?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.labelMedium,
    ),
    headlineMedium: base.headlineMedium?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.headlineMedium,
    ),
    displayMedium: base.displayMedium?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.displayMedium,
    ),

    bodySmall: base.bodySmall?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.bodySmall,
    ),
    titleSmall: base.titleSmall?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.titleSmall,
    ),

    headlineSmall: base.headlineSmall?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.headlineSmall,
    ),
    labelSmall: base.labelSmall?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.labelSmall,
    ),
    displaySmall: base.displaySmall?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.displaySmall,
    ),
    headlineLarge: base.headlineLarge?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.headlineLarge,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontFamily: fontFamily,
      color: AppColors.bodyLarge,
      fontSize: 40,
    ),
  );
}
