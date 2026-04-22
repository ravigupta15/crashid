class OtpState {
  final bool? isLoading;

  OtpState({this.isLoading});

  OtpState.initial() : isLoading = false;

  OtpState copyWith({
    bool? isLoading,
  }) {
    return OtpState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
