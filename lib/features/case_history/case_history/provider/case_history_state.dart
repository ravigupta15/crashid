class CaseHistoryState {
  final bool? isLoading;

  CaseHistoryState({this.isLoading,});

  CaseHistoryState.initial() : isLoading = false;

  CaseHistoryState copyWith({bool? isLoading}) {
    return CaseHistoryState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
