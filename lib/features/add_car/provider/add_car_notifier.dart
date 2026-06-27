import 'dart:async';

import 'package:crashid/features/add_car/model/add_car_send_model.dart';
import 'package:crashid/features/add_car/model/brands_model.dart';
import 'package:crashid/features/add_car/model/colors_model.dart';
import 'package:crashid/features/add_car/model/md_model.dart';
import 'package:crashid/features/add_car/provider/add_car_state.dart';
import 'package:crashid/features/add_car/repository/add_car_repository.dart';
import 'package:crashid/features/my_insurance/model/insurance_response_model.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addCarNotifierProvider =
    AsyncNotifierProvider<AddCarNotifier, AddCarState>(AddCarNotifier.new);

class AddCarNotifier extends AsyncNotifier<AddCarState> {
  @override
  FutureOr<AddCarState> build() {
    return AddCarState.initial();
  }

  Future carBrands(BuildContext context) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(addCarRepositoryProvider);
      final response = await repo.carBrands();
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        state = AsyncData(state.value!.copyWith(brandsModel: BrandsModel.fromJson(response?.data)));
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

  Future carModels(BuildContext context, {AddCarSendModel? model}) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(addCarRepositoryProvider);
      final response = await repo.carModels(model: model);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        state = AsyncData(state.value!.copyWith(mdModel: MdModel.fromJson(response?.data)));
      }
    } catch (_) {
    } finally {
      LoaderService().hideLoader();
    }
  }

  Future carColors() async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(addCarRepositoryProvider);
      final response = await repo.carColors();
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        state = AsyncData(state.value!.copyWith(colorsModel: ColorsModel.fromJson(response?.data)));
      }
    } catch (_) {
     } finally {
      LoaderService().hideLoader();
    }
  }

  Future insurance() async {
    try {
      final repo = ref.read(addCarRepositoryProvider);
      final response = await repo.insurance();
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        state = AsyncData(state.value!.copyWith(insuranceResponseModel: InsuranceResponseModel.fromJson(response?.data)));
      }
    } catch (_) {
     } finally {
    }
  }

  Future<bool> addCar(BuildContext context, {AddCarSendModel? model}) async {
    LoaderService().showLoader();
    try {
      final repo = ref.read(addCarRepositoryProvider);
      final response = await repo.addCar(model: model);
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        showFeedbackMessage(
          response?.data['message'] ?? 'Car added successfully.',
        );
        _openMyCarsScreen(context);
        return true;
      }
      return false;
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

  void _openMyCarsScreen(BuildContext context) {
    Navigator.pop(context);
  }
}
