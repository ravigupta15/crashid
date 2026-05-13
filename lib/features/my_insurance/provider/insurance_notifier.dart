import 'dart:async';
import 'package:crashid/features/my_insurance/model/insurance_response_model.dart';
import 'package:crashid/features/my_insurance/provider/insurane_state.dart';
import 'package:crashid/features/my_insurance/repository/insurance_repository.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InsuranceNotifier extends AsyncNotifier<InsuraneState> {
  @override
  FutureOr<InsuraneState> build() {
    return InsuraneState.initial();
  }

  Future<void> insuranceApi() async {
    try {
      LoaderService().showLoader();
      final repo = ref.read(insuranceRepositoryProvider);
      final response = await repo.insurance();
      if (response?.statusCode == 200 ) {
        final model = InsuranceResponseModel.fromJson(response?.data);
        state = AsyncData(state.value!.copyWith(
          insuranceResponseModel: model,
        ));
      }
    } catch (_) {
    }
     finally {
      LoaderService().hideLoader();
    }
  }

}

