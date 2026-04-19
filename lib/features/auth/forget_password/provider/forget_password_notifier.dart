import 'dart:async';

import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/features/auth/aut_repository/auth_repository.dart';
import 'package:crashid/features/auth/forget_password/model/forget_send_model.dart';
import 'package:crashid/features/auth/forget_password/presentation/pages/otp_screen.dart';
import 'package:crashid/features/auth/forget_password/presentation/widgets/check_email_widget.dart';
import 'package:crashid/features/auth/forget_password/provider/forget_password_state.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPasswordNotifier extends AsyncNotifier<ForgetPasswordState> {
  @override
  FutureOr<ForgetPasswordState> build() {
    return ForgetPasswordState.initial();
  }

  Future<bool> forgotPassword(BuildContext context,{
    ForgetPasswordSendModel? model,}
  ) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.forgotPassword(model: model);
      _openDialogBox();
      return true;
    } catch (_) {
      if (context.mounted) {
        showFeedbackMessage(
          'Something went wrong. Please try again.',
          context: context,
          feedbackStyle: FeedbackStyle.snackBar,
          snackBarBgColor: AppColors.redColor,
        );
      }
      return false;
    } finally {
      LoaderService().hideLoader();
    }
  }

  void _openDialogBox() {
    var size = MediaQuery.of(AppRouter.mainNavigatorKey.currentContext!).size;
    AppDialogBox().openBox(
      maxWidthMinWidth: size.width * .8,
      barrierDismissible: false,
      screenContent: CheckEmailWidget(
        onTap: _openOtpScreen,
      ),
    );
  }

  void _openOtpScreen() {
    OtpScreen.open(AppRouter.mainNavigatorKey.currentContext!);
  }

}
