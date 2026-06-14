class ChooseAccountState {
  final bool? isLoading;

  ChooseAccountState({this.isLoading});

  ChooseAccountState .initial() : isLoading = false;

  ChooseAccountState copyWith({
    bool? isLoading,
  }) {
    return ChooseAccountState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
