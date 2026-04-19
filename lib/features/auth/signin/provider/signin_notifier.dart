// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/di/service_locator.dart';
import 'package:crashid/features/app_navigation/presentation/pages/app_navigation_screen.dart';
import 'package:crashid/features/auth/aut_repository/auth_repository.dart';
import 'package:crashid/features/auth/signin/model/sign_in_model.dart';
import 'package:crashid/features/auth/signin/model/signin_response_model.dart';
import 'package:crashid/features/auth/signin/provider/signin_state.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class SigninNotifier extends AsyncNotifier<SigninState> {
  @override
  FutureOr<SigninState> build() {
    return SigninState.initial();
  }

  Future<void> login(BuildContext context, SignInSendModel? model) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(authRepositoryProvider);
      final response = await repo.login(model: model);
       if (response.statusCode == 200) {
        var model = SignInResponseModel.fromJson(response.data);
        GetIt.I<SecureStorage>().setUserToken(model.data?.accessToken ?? '');
        _openAppNavigationScreen();
       }
    } 
     catch (_) {
      showFeedbackMessage(
        'Something went wrong. Please try again.',
        context: context,
        feedbackStyle: FeedbackStyle.snackBar,
        snackBarBgColor: AppColors.redColor,
      );
    } finally {
      LoaderService().hideLoader();
    }
  }


  void _openAppNavigationScreen() {
    AppNavigationScreen.open(AppRouter.mainNavigatorKey.currentContext!);
  }
}
