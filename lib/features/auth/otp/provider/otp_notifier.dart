import 'dart:async';

import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/features/app_navigation/presentation/pages/app_navigation_screen.dart';
import 'package:crashid/features/auth/aut_repository/auth_repository.dart';
import 'package:crashid/features/auth/otp/model/otp_send_model.dart';
import 'package:crashid/features/auth/otp/provider/otp_state.dart';
import 'package:crashid/features/auth/reset_password/presentation/pages/reset_password_screen.dart';
import 'package:crashid/features/auth/signin/model/signin_response_model.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class OtpNotifier extends AsyncNotifier<OtpState> {
  @override
  FutureOr<OtpState> build() {
    return OtpState.initial();
  }

  
  Future verifyOtp(BuildContext context,{
    OtpSendModel? model,}
  ) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.verifyOtp(model: model);
      if (response?.statusCode == 200) {
        if(model?.type == "registration") {
          var model = SignInResponseModel.fromJson(response?.data);
          GetIt.I<SecureStorage>().setUserToken(model.data?.accessToken ?? '');
          GetIt.I<SecureStorage>().setRefreshToken(model.data?.refreshToken ?? '');
          _openAppNavigationScreen();
          return;
        }
         _openResetPasswordScreen(response?.data['data']['reset_token']);
      }
    } catch (_) {
      if (context.mounted) {
        showFeedbackMessage(
          'Something went wrong. Please try again.',
          context: context,
          feedbackStyle: FeedbackStyle.snackBar,
          snackBarBgColor: AppColors.redColor,
        );
      }
    } finally {
      LoaderService().hideLoader();
    }
  }

  
  Future<bool> resendOtp(BuildContext context,{
    OtpSendModel? model,}
  ) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.resendOtp(model: model);
      if (response?.statusCode == 200) {
        showFeedbackMessage(
          response?.data['message'] ?? AppLocalizations.of(context)!.otpResentSuccessfully,
        );
        return true;
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

  void _openResetPasswordScreen(String? token) {
    ResetPasswordScreen.open(AppRouter.mainNavigatorKey.currentContext!, token: token);
  }

  void _openAppNavigationScreen() {
    AppNavigationScreen.open(AppRouter.mainNavigatorKey.currentContext!);
  }
}
