import 'package:flutter/material.dart';

class AppPaddings {
  /// Common screen padding (used for most pages)
  static const screenPadding = EdgeInsets.symmetric(
    horizontal: 30,
    vertical: 50,
  );

  /// Tight padding for dense layouts
  static const compact = EdgeInsets.symmetric(horizontal: 12, vertical: 16);

  /// Extra spacious padding for large content or tablet
  static const large = EdgeInsets.symmetric(horizontal: 32, vertical: 40);

  /// Only horizontal padding
  static const horizontal = EdgeInsets.symmetric(horizontal: 20);

  /// Only vertical padding
  static const vertical = EdgeInsets.symmetric(vertical: 24);

  //// screen
  static double screenLeft = 20;
  static double screenRight = 20;
  static double screenBottom = 40;
  static double screenTop = 50;
  static double screenHorizontal = 20;
  static double screenVertical = 24;
}
