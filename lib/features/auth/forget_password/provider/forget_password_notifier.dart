import 'dart:async';

import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/features/auth/aut_repository/auth_repository.dart';
import 'package:crashid/features/auth/forget_password/model/forget_send_model.dart';
import 'package:crashid/features/auth/otp/presentation/pages/otp_screen.dart';
import 'package:crashid/features/auth/forget_password/presentation/widgets/check_email_widget.dart';
import 'package:crashid/features/auth/forget_password/provider/forget_password_state.dart';
import 'package:crashid/features/auth/registration/model/registration_response_model.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPasswordNotifier extends AsyncNotifier<ForgetPasswordState> {
  @override
  FutureOr<ForgetPasswordState> build() {
    return ForgetPasswordState.initial();
  }

  Future<bool> forgotPassword(BuildContext context,{
    ForgetPasswordSendModel? sendModel,}
  ) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(authRepositoryProvider);
     final response = await repo.forgotPassword(model: sendModel);
      if (response?.statusCode == 200) {
        var model = RegistrationResponseModel.fromJson(response?.data);
        _openDialogBox(model.data?.userId, sendModel?.email);
      }
      return true;
    } catch (_) {
      if (context.mounted) {
        showFeedbackMessage(
          AppLocalizations.of(context)!.somethingWentWrong,
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

  
  void _openDialogBox(int? userId, String? email) {
    var size = MediaQuery.of(AppRouter.mainNavigatorKey.currentContext!).size;
    AppDialogBox().openBox(
      maxWidthMinWidth: size.width * .8,
      barrierDismissible: false,
      screenContent: CheckEmailWidget(
        onTap: () => _openOtpScreen(userId, email),
      ),
    );
  }

  void _openOtpScreen(int? userId, String? email) {
    Navigator.pop(AppRouter.mainNavigatorKey.currentContext!);
    OtpScreen.open(AppRouter.mainNavigatorKey.currentContext!, id: userId?.toString(), type: "forgot_password", email: email);
  }

}
