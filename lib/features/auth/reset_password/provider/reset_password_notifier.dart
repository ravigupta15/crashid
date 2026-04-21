import 'dart:async';

import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/features/auth/aut_repository/auth_repository.dart';
import 'package:crashid/features/auth/reset_password/model/reset_password_send_model.dart';
import 'package:crashid/features/auth/reset_password/presentation/widgets/password_change_confirmation_widget.dart';
import 'package:crashid/features/auth/reset_password/provider/reset_password_state.dart';
import 'package:crashid/features/auth/signin/presentation/pages/signin_screen.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordNotifier extends AsyncNotifier<ResetPasswordState> {
  @override
  FutureOr<ResetPasswordState> build() {
    return ResetPasswordState.initial();
  }

  Future<bool> resetPassword(BuildContext context,{
    ResetPasswordSendModel? model,}
  ) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.resetPassword(model: model);
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
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.of(AppRouter.mainNavigatorKey.currentContext!).size.width * .8,
      screenContent: PasswordChangeConfirmationWidget(
        onTap: _openSignInSCreen,
      )
    );
  }

  void _openSignInSCreen() {
    SigninScreen.openRemove(AppRouter.mainNavigatorKey.currentContext!);
  }

 
}
