import 'package:flutter/material.dart';

SnackBar createSnackBar(String message, Color bgColor) {
  return SnackBar(
    backgroundColor: bgColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
    content: Text(message),
  );
}

void showSnackBarWithContext(SnackBar snackBar, BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void showSnackBarMassage(String message, BuildContext context, {Color? bgColor}) {
  showSnackBarWithContext(createSnackBar(message,bgColor ?? Colors.green), context,);
}
