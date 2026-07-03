// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/features/app_navigation/presentation/pages/app_navigation_screen.dart';
import 'package:crashid/core/service/auth/facebook_auth_service.dart';
import 'package:crashid/core/service/auth/google_auth_service.dart';
import 'package:crashid/core/service/auth/social_auth_result.dart';
import 'package:crashid/features/auth/aut_repository/auth_repository.dart';
import 'package:crashid/features/auth/registration/presentation/pages/choose_account_type_screen.dart';
import 'package:crashid/features/auth/signin/model/sign_in_model.dart';
import 'package:crashid/features/auth/signin/model/signin_response_model.dart';
import 'package:crashid/features/auth/signin/model/social_sign_in_model.dart';
import 'package:crashid/features/auth/signin/provider/signin_state.dart';
import 'package:crashid/l10n/app_localizations.dart';
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

      if (response?.statusCode == 200) {
        _saveTokensAndNavigate(response?.data, context, false);
      }
    } catch (_) {
      showFeedbackMessage(
        AppLocalizations.of(context)!.somethingWentWrong,
        context: context,
        feedbackStyle: FeedbackStyle.snackBar,
        snackBarBgColor: AppColors.redColor,
      );
    } finally {
      LoaderService().hideLoader();
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    await _socialSignIn(
      context: context,
      signIn: GoogleAuthService.instance.signIn,
      apiCall: (model) => ref.read(authRepositoryProvider).socialLogin(model: model),
    );
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    await _socialSignIn(
      context: context,
      signIn: FacebookAuthService.instance.signIn,
      apiCall: (model) => ref.read(authRepositoryProvider).socialLogin(model: model),
    );
  }

  Future<void> _socialSignIn({
    required BuildContext context,
    required Future<SocialAuthResult?> Function() signIn,
    required Future<dynamic> Function(SocialSignInSendModel model) apiCall,
  }) async {
    try {
      // Keep the loader hidden while the external OAuth UI is open so the
      // redirect back into the app is not blocked.
      final result = await signIn();
      print("Social sign-in result: ${result?.provider}, ${result?.email}, ${result?.displayName}");
      if (result == null) return;

      LoaderService().showLoader();
      try {
        final response = await apiCall(SocialSignInSendModel.fromResult(result));
        if (response?.statusCode == 200) {
          _saveTokensAndNavigate(response?.data, context, true);
        }
      } finally {
        LoaderService().hideLoader();
      }
    } catch (error) {
      print("Error occurred during social sign-in: $error");
      showFeedbackMessage(
        AppLocalizations.of(context)!.somethingWentWrong,
        context: context,
        feedbackStyle: FeedbackStyle.snackBar,
        snackBarBgColor: AppColors.redColor,
      );
    }
  }

  void _saveTokensAndNavigate(dynamic data, BuildContext context, bool? social) {
    final model = SignInResponseModel.fromJson(data);
    GetIt.I<SecureStorage>().setUserToken(model.data?.accessToken ?? '');
    GetIt.I<SecureStorage>().setRefreshToken(model.data?.refreshToken ?? '');
    GetIt.I<UserManager>().setProfileComplete = model.data?.profileComplete == true;
   if (social == true) {
  if (model.data?.profileComplete == true) {
      _openAppNavigationScreen();
    } else {
      _openChooseAccountTypeScreen(context);
    }
   } else {
    GetIt.I<UserManager>().setProfileComplete = true;
      _openAppNavigationScreen();
   }
  
  }

  void _openAppNavigationScreen() {
    AppNavigationScreen.open(AppRouter.mainNavigatorKey.currentContext!);
  }

  void _openChooseAccountTypeScreen(BuildContext context) {
    ChooseAccountTypeScreen.open(context, shouldCallApi: true);
  }
}
