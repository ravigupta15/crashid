import 'dart:async';
import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/features/add_accident/model/add_accident_send_model.dart';
import 'package:crashid/features/add_accident/model/pricing_response_model.dart';
import 'package:crashid/features/add_accident/presentation/pages/other_accident_screen.dart';
import 'package:crashid/features/add_accident/provider/add_accident_state.dart';
import 'package:crashid/features/add_accident/repository/accident_repository.dart';
import 'package:crashid/features/emergency/add_emergency/model/search_user_response_model.dart';
import 'package:crashid/features/lookup/repository/lookup_repository.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAccidentNotifier extends AsyncNotifier<AddAccidentState> {
  @override
  FutureOr<AddAccidentState> build() {
    return AddAccidentState.initial();
  }


Future searchPlateNumber(String? queryString) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(lookupRepositoryProvider);
      final response = await repo.searchApi(queryString);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
           state = AsyncData(
          state.value!.copyWith(searchUserResponseModel: SearchUserResponseModel.fromJson(response?.data)));
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }


  Future pricing() async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.pricing();
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        state = AsyncData(state.value!.copyWith(pricingResponseModel: PricingResponseModel.fromJson(response?.data)));
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

  

  Future addAccident(AddAccidentSendModel? sendModel) async {
    LoaderService().showLoader();
    try {
      print(sendModel?.model?.vehicleId);
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.addAccident(sendModel);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        _openOtherAccidentScreen();
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

   void _openOtherAccidentScreen() {
  OtherAccidentScreen.open(AppRouter.mainNavigatorKey.currentContext!);
 }

}
