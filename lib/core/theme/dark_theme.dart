import 'package:flutter/material.dart';
import 'package:crashid/core/theme/text_theme.dart';
import 'package:crashid/res/app_colors.dart';

ThemeData get darkTheme => ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: AppColors.whiteColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.blackColor,
    foregroundColor: AppColors.whiteColor,
    elevation: 0,
  ),
  textTheme: appTextTheme(ThemeData.dark().textTheme, Brightness.dark),
);
