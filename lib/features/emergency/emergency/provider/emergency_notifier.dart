import 'dart:async';
import 'package:crashid/features/emergency/emergency/model/emergency_response_model.dart';
import 'package:crashid/features/emergency/emergency/model/sos_send_model.dart';
import 'package:crashid/features/emergency/emergency/provider/emergency_state.dart';
import 'package:crashid/features/emergency/repository/emergency_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class EmergencyNotifier extends AsyncNotifier<EmergencyState> {
  @override
  FutureOr<EmergencyState> build() {
    return EmergencyState.initial();
  }

  Future<bool> emergencyApi() async {
    try {
      final repo = ref.read(emergencyRepositoryProvider);
      final response = await repo.emergency();
      if (response?.statusCode == 200) {
        var model = EmergencyResponseModel.fromJson(response?.data);
        state = AsyncData(
          state.value!.copyWith(emergencyResponseModel: model));
       if ((model.data ?? []).isNotEmpty) {
        return true;
       } 
       return false;
      }
    } catch (_) {
    } 
    return false;
  }

  
  Future sosEmergencyApi(SosSendModel? sendModel) async {
    try {
      final repo = ref.read(emergencyRepositoryProvider);
      final response = await repo.sosEmergency(sendModel);
      if (response?.statusCode == 200) {
        // var model = EmergencyResponseModel.fromJson(response?.data);
        // state = AsyncData(
        //   state.value!.copyWith(emergencyResponseModel: model));
      }
    } catch (_) {
    } 
  }


}
