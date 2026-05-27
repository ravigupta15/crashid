import 'dart:async';
import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/features/add_accident/model/accident_response_model.dart';
import 'package:crashid/features/add_accident/model/add_accident_send_model.dart';
import 'package:crashid/features/add_accident/model/pricing_response_model.dart';
import 'package:crashid/features/add_accident/presentation/pages/other_accident_screen.dart';
import 'package:crashid/features/add_accident/provider/add_accident_state.dart';
import 'package:crashid/features/add_accident/repository/accident_repository.dart';
import 'package:crashid/features/my_cars/model/my_car_response_model.dart';
import 'package:crashid/features/my_cars/my_car_repository/my_car_repository.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAccidentNotifier extends AsyncNotifier<AddAccidentState> {
  @override
  FutureOr<AddAccidentState> build() {
    return AddAccidentState.initial();
  }


Future searchPlateNumber(String? queryString) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(myCarRepositoryProvider);
      final response = await repo.myCar();
      if (response?.statusCode == 201 || response?.statusCode == 200) {
           state = AsyncData(
          state.value!.copyWith(myCarResponseModel: MyCarResponseModel.fromJson(response?.data)));
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
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.addAccident(sendModel);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
       var model = AccidentResponseModel.fromJson(response?.data);
        _openOtherAccidentScreen((model.data?.id ?? '').toString());
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

  
  Future userBAccept(AddAccidentSendModel? sendModel) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.userBAccept(sendModel: sendModel);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        showFeedbackMessage(response?.data['message'] ?? '');
        Navigator.pop(AppRouter.mainNavigatorKey.currentContext!);  
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

  
  Future userWitnessAccept(AddAccidentSendModel? sendModel) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(accidentRepositoryProvider);
      final response = await repo.witnessResponse(sendModel: sendModel);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        showFeedbackMessage(response?.data['message'] ?? '');
        Navigator.pop(AppRouter.mainNavigatorKey.currentContext!);  
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

   void _openOtherAccidentScreen(String caseId) {
  OtherAccidentScreen.open(AppRouter.mainNavigatorKey.currentContext!, caseId: caseId, route: "add_accident");
 }

}
