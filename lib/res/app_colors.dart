import 'package:flutter/services.dart';

class AppColors {
  AppColors._();

  static const primaryColor = Color(0xff0F70A9);
  static const darkGrayColor = Color(0xff2A2A2A);
  static const accentColor = Color(0xffffd500);
  static const blackColor = Color(0xff000000);
  static const whiteColor = Color(0xffffffff);
  static const lightGrayColor = Color(0xffDADADA);
  
  static const Color redColor = Color(0xffED1C24);

// “On” colors (Now Dark for White Backgrounds)
  static const Color onPrimary = whiteColor;    // Keep white if Primary Button is dark
  static const Color onSecondary = whiteColor;  // Keep white if Secondary Button is dark
  static const Color onBackground = blackColor; // Text on the main screen
  static const Color onSurface = Color(0xDE000000); // 87% Black for primary text
// Typography Colors
  static const Color titleMedium = onBackground;
  static const Color headlineMedium = onBackground;
  static const Color displayMedium = onBackground;
  static const Color headlineLarge = onBackground;
  static const Color displaySmall = onBackground;
  static const Color headlineSmall = onBackground;

  // Medium emphasis text (Body)
  static const Color bodyLarge = Color(0xDE000000);  // 87% black
  static const Color bodyMedium = Color(0xBD000000); // 74% black
  static const Color titleSmall = Color(0xDE000000); // 87% black

  // Low emphasis text (Labels / Captions)
  static const Color labelMedium = Color(0x99000000); // 60% black
  static const Color bodySmall = Color(0x99000000);  // 60% black
  static const Color labelSmall = Color(0x80000000);  // 50% black

}