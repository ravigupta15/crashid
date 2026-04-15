import 'package:flutter/services.dart';

class AppColors {
  AppColors._();

  static const primaryColor = Color(0xff0F70A9);
  static const darkGrayColor = Color(0xff2A2A2A);
  static const accentColor = Color(0xffffd500);
  static const blackColor = Color(0xff000000);
  static const whiteColor = Color(0xffffffff);


    // “On” colors (text/icons on top of backgrounds)
  static const Color onPrimary = whiteColor;
  static const Color onSecondary = whiteColor;
  static const Color onBackground = whiteColor;
  static const Color onSurface = Color(0xE6FFFFFF); // 90% white

  static const Color bodyMedium = Color(0xB3FFFFFF); // 70% white on dark bg
  static const Color titleMedium = onBackground;
  static const Color labelMedium = Color(0x99FFFFFF); // 60% white
  static const Color headlineMedium = onBackground;
  static const Color displayMedium = onBackground;

  static const Color bodySmall = Color(0x99FFFFFF); // 60% white
  static const Color titleSmall = Color(0xCCFFFFFF); // 80% white
  static const Color headlineSmall = onBackground;
  static const Color labelSmall = Color(0x80FFFFFF); // 50% white
  static const Color displaySmall = onBackground;
  static const Color headlineLarge = onBackground;
  static const Color bodyLarge = onSurface;

}