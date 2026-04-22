class RegistrationState {
  final bool? isLoading;

  RegistrationState({this.isLoading});

  RegistrationState .initial() : isLoading = false;

  RegistrationState copyWith({
    bool? isLoading,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
