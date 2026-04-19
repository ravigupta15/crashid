class SigninState {
  final bool? isLoading;

  SigninState({this.isLoading});

  SigninState.initial()
      : isLoading = false;

  SigninState copyWith({
    bool? isLoading,
  }) {
    return SigninState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
