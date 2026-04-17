 import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

Widget indicatorWidget(bool isActive, {Color? inactiveColor, Color? activeColor}) {
    return SizedBox(
      height: 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 9.0,
        width: isActive ? 10 : 9.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: !isActive
              ? activeColor ?? AppColors.blackColor
              : inactiveColor ?? AppColors.lightGrayColor,
        ),
      ),
    );
  }