import 'package:flutter/material.dart';
import 'package:crashid/core/theme/text_theme.dart';
import 'package:crashid/res/app_colors.dart';

ThemeData get lightTheme => ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: AppColors.whiteColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.whiteColor,
    foregroundColor: AppColors.whiteColor,
    elevation: 0,
  ),
  textTheme: appTextTheme(ThemeData.light().textTheme, Brightness.light),
);
