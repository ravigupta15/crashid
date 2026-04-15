import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message, {Color? color}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: color ?? AppColors.blackColor,
      textColor: AppColors.whiteColor,
      fontSize: 16.0);
}
