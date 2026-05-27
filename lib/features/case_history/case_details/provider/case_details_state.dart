import 'package:crashid/features/case_history/case_details/model/case_details_response_model.dart';

class CaseDetailsState {
  final bool? isLoading;
  final CaseDetailsResponseModel? caseDetailsResponseModel;

  CaseDetailsState({this.isLoading, this.caseDetailsResponseModel});

  CaseDetailsState.initial() : isLoading = false, caseDetailsResponseModel = null;

  CaseDetailsState copyWith({
    bool? isLoading, 
    CaseDetailsResponseModel? caseDetailsResponseModel}) {
    return CaseDetailsState(
      isLoading: isLoading ?? this.isLoading,
      caseDetailsResponseModel: caseDetailsResponseModel ?? this.caseDetailsResponseModel
    );
  }
}
