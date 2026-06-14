import 'dart:async';

import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/features/app_navigation/presentation/pages/app_navigation_screen.dart';
import 'package:crashid/features/auth/aut_repository/auth_repository.dart';
import 'package:crashid/features/auth/registration/provider/choose_account_state.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class ChooseAccountNotifier extends AsyncNotifier<ChooseAccountState> {
  @override
  FutureOr<ChooseAccountState> build() {
    return ChooseAccountState.initial();
  }

  Future<bool> completeProfile(BuildContext context,{
    String? accountType,}
  ) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.completeProfile(accountType: accountType);
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        _openAppNavigationScreen();
      }
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


  void _openAppNavigationScreen() {
    GetIt.I<UserManager>().setProfileComplete = false;
    AppNavigationScreen.open(AppRouter.mainNavigatorKey.currentContext!);
  }
}
