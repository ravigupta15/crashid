import 'dart:async';

import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/features/auth/aut_repository/auth_repository.dart';
import 'package:crashid/features/auth/otp/presentation/pages/otp_screen.dart';
import 'package:crashid/features/auth/forget_password/presentation/widgets/check_email_widget.dart';
import 'package:crashid/features/auth/registration/model/registration_response_model.dart';
import 'package:crashid/features/auth/registration/model/registration_send_model.dart';
import 'package:crashid/features/auth/registration/provider/registration_state.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationNotifier extends AsyncNotifier<RegistrationState> {
  @override
  FutureOr<RegistrationState> build() {
    return RegistrationState.initial();
  }

  Future<bool> personalRegistration(BuildContext context,{
    RegistrationSendModel? sendModel,}
  ) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.personalRegistration1(model: sendModel);
      if (response?.statusCode == 201) {
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

  Future<bool> companyRegistration(
    BuildContext context, {
    RegistrationSendModel? sendModel,
  }) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.companyRegistration(model: sendModel);
      if (response?.statusCode == 201) {
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
    OtpScreen.open(AppRouter.mainNavigatorKey.currentContext!, 
    id: userId?.toString(),
    type: "registration",
    email: email,
    );
  }

}
