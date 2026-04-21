class ResetPasswordState {
  final bool? isLoading;

  ResetPasswordState({this.isLoading});

  ResetPasswordState.initial() : isLoading = false;

  ResetPasswordState copyWith({
    bool? isLoading,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
