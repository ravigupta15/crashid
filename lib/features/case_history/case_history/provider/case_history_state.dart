import 'package:crashid/features/case_history/model/case_history_response_model.dart';

class CaseHistoryState {
  final bool? isLoading;
  final CaseHistoryResponseModel? caseHistoryResponseModel;

  CaseHistoryState({this.isLoading, this.caseHistoryResponseModel});

  CaseHistoryState.initial() : isLoading = false, caseHistoryResponseModel = null;

  CaseHistoryState copyWith({bool? isLoading, CaseHistoryResponseModel? caseHistoryResponseModel}) {
    return CaseHistoryState(
      isLoading: isLoading ?? this.isLoading,
      caseHistoryResponseModel: caseHistoryResponseModel ?? this.caseHistoryResponseModel
    );
  }
}
