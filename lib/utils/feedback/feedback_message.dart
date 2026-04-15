import 'package:crashid/utils/feedback/feedback_snackbar.dart';
import 'package:crashid/utils/feedback/feedback_toast.dart';
import 'package:flutter/material.dart';

void showFeedbackMessage(String message,
    {FeedbackStyle feedbackStyle = FeedbackStyle.toast,
    Color? snackBarBgColor,
    BuildContext? context}) {
  switch (feedbackStyle) {
    case FeedbackStyle.toast:
      showToast(message, color: snackBarBgColor);
      break;
    case FeedbackStyle.snackBar:
      if (context != null) {
        showSnackBarMassage(message, context, bgColor: snackBarBgColor);
      }
      break;
  }
}

enum FeedbackStyle {
  toast,
  snackBar,
}
