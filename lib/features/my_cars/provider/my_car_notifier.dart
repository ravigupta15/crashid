import 'dart:async';
import 'package:crashid/features/my_cars/model/car_details_response_model.dart';
import 'package:crashid/features/my_cars/model/my_car_response_model.dart';
import 'package:crashid/features/my_cars/my_car_repository/my_car_repository.dart';
import 'package:crashid/features/my_cars/provider/my_car_state.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MyCarNotifier extends AsyncNotifier<MyCarState> {
  @override
  FutureOr<MyCarState> build() {
    return MyCarState.initial();
  }

  Future<bool> myCar(BuildContext context,) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(myCarRepositoryProvider);
      final response = await repo.myCar();
      if (response?.statusCode == 200) {
        var model = MyCarResponseModel.fromJson(response?.data);
        state = AsyncData(
          state.value!.copyWith(myCarResponseModel: model));
      return  (model.data ?? []).isEmpty ? false : true;
      }
    } catch (_) {
    } finally {
      LoaderService().hideLoader();
    }
    return false;
  }
  
  Future myCarDetails(String carId) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(myCarRepositoryProvider);
      final response = await repo.myCarDetails(carId);
      if (response?.statusCode == 200) {
        state = AsyncData(
          state.value!.copyWith(carDetailsResponseModel: CarDetailsResponseModel.fromJson(response?.data)));
      }
    } catch (_) {
    } finally {
      LoaderService().hideLoader();
    }
  }
}
