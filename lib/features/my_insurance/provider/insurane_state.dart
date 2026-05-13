import 'package:crashid/features/my_insurance/model/insurance_response_model.dart';

class InsuraneState {
  final bool isLoading;
  final InsuranceResponseModel? insuranceResponseModel;

  const InsuraneState({
    required this.isLoading,
    this.insuranceResponseModel,
  });

  factory InsuraneState.initial() {
    return const InsuraneState(
      isLoading: false,
      insuranceResponseModel  : null,
    );
  }

  InsuraneState copyWith({
    bool? isLoading,
    InsuranceResponseModel? insuranceResponseModel,
  }) {
    return InsuraneState(
      isLoading: isLoading ?? this.isLoading,
      insuranceResponseModel: insuranceResponseModel ?? this.insuranceResponseModel,
    );
  }
}
