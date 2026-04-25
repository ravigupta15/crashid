import 'dart:async';
import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/features/profile/model/profile_response_model.dart';
import 'package:crashid/features/profile/model/profile_send_model.dart';
import 'package:crashid/features/profile/provider/profile_state.dart';
import 'package:crashid/features/profile/repostiory/profile_repository.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileNotifier extends AsyncNotifier<ProfileState> {
  @override
  FutureOr<ProfileState> build() {
    return ProfileState.initial();
  }

  Future<void> getProfile(BuildContext context) async {
    try {
      LoaderService().showLoader();
      final repo = ref.read(profileRepositoryProvider);
      final response = await repo.getProfile();
      if (response?.statusCode == 200 ) {
        final model = ProfileResponseModel.fromJson(response?.data);
        state = AsyncData(state.value!.copyWith(
          profileResponseModel: model,
        ));
      }
    } catch (_) {
    }
     finally {
      LoaderService().hideLoader();
    }
  }

  
  Future<void> editProfile(ProfileSendModel? sendModel) async {
    try {
      LoaderService().showLoader();
      final repo = ref.read(profileRepositoryProvider);
      final response = await repo.editProfile(sendModel);
      if (response?.statusCode == 200 ) {
        Navigator.pop(AppRouter.mainNavigatorKey.currentContext!);
      }
    } catch (_) {
    }
     finally {
      LoaderService().hideLoader();
    }
  }
  
}
  
final profileNotifier =
    AsyncNotifierProvider<ProfileNotifier, ProfileState>(ProfileNotifier.new);

