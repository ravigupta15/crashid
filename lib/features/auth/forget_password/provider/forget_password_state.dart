class ForgetPasswordState {
  final bool? isLoading;

  ForgetPasswordState({this.isLoading});

  ForgetPasswordState.initial() : isLoading = false;

  ForgetPasswordState copyWith({
    bool? isLoading,
  }) {
    return ForgetPasswordState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
