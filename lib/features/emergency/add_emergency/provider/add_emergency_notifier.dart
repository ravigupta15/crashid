import 'dart:async';
import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/emergency/add_emergency/model/add_emergency_send_model.dart';
import 'package:crashid/features/emergency/add_emergency/model/search_user_response_model.dart';
import 'package:crashid/features/emergency/add_emergency/provider/add_emergency_state.dart';
import 'package:crashid/features/emergency/repository/emergency_repository.dart';
import 'package:crashid/features/lookup/repository/lookup_repository.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AddEmergencyNotifier extends AsyncNotifier<AddEmergencyState> {
  @override
  FutureOr<AddEmergencyState> build() {
    return AddEmergencyState.initial();
  }

  Future<bool> searchApi({String? search}) async {
    try {
      final repo = ref.read(lookupRepositoryProvider);
      final response = await repo.searchApi(search);
      if (response?.statusCode == 200) {
        state = AsyncData(
          state.value!.copyWith(searchUserResponseModel: SearchUserResponseModel.fromJson(response?.data)));
      }
    } catch (_) {
    } 
    return false;
  }

  void addEmergency({AddEmergencySendModel? sendModel}) async {
    try {
      LoaderService().showLoader();
      final repo = ref.read(emergencyRepositoryProvider);
      final response = await repo.addEmergency(sendModel);
      if (response?.statusCode == 201) {
        _openSuccessDialogBox();
      }
    } catch (_) {
    } finally {
   LoaderService().hideLoader();
    }
  }
  
   void _openSuccessDialogBox() {
    final context = AppRouter.mainNavigatorKey.currentContext!;
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.of(context).size.width - 100,
      screenContent: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 25, left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close,))),
              const SizedBox(height: 20,),
              Image.asset(AppAssetPaths.successIcon),
              const SizedBox(height: 10,),
              Text("Emergency contact added\nsuccessfully",
              textAlign: TextAlign.center,
              style: context.titleMedium.copyWith(
                fontSize: 14, color: AppColors.darkGrayColor,
                fontWeight: FontWeight.w800
              ),
              )
          ],
        ),
      )
    );
  }

}
