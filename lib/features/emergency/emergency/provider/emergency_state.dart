import 'package:crashid/features/emergency/emergency/model/emergency_response_model.dart';

class EmergencyState {
  final bool? isLoading;
  EmergencyResponseModel? emergencyResponseModel;

  EmergencyState({this.isLoading, this.emergencyResponseModel,});

  EmergencyState.initial() : isLoading = false, emergencyResponseModel = null;

  EmergencyState copyWith({bool? isLoading, EmergencyResponseModel? emergencyResponseModel}) {
    return EmergencyState(
      isLoading: isLoading ?? this.isLoading,
      emergencyResponseModel: emergencyResponseModel ?? this.emergencyResponseModel,
    );
  }
}
