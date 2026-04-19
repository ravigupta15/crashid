import 'dart:async';
import 'package:crashid/features/auth/aut_repository/auth_repository.dart';
import 'package:crashid/features/auth/signin/model/sign_in_model.dart';
import 'package:crashid/features/auth/signin/provider/signin_state.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SinginNotifier extends AsyncNotifier<SigninState> {
  @override
  FutureOr<SigninState> build() {
    return SigninState.initial();
  }

  Future<void> login(BuildContext context, SignInSendModel? model) async {
    
     final repo = ref.read(authRepositoryProvider);
      LoaderService().showLoader(); 
      try {
        final response = await repo.login(model: model);
       
        LoaderService().hideLoader();

      } finally {
        LoaderService().hideLoader();
      }
  }
}

final signinNotifierProvider =
    AsyncNotifierProvider<SinginNotifier, SigninState>(SinginNotifier.new);
