import 'package:crashid/features/profile/model/profile_response_model.dart';

class NotificationState {
  final bool isLoading;
  final ProfileResponseModel? profileResponseModel;

  const NotificationState({
    required this.isLoading,
    this.profileResponseModel,
  });

  factory NotificationState.initial() {
    return const NotificationState(
      isLoading: false,
      profileResponseModel  : null,
    );
  }

  NotificationState copyWith({
    bool? isLoading,
    ProfileResponseModel? profileResponseModel,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      profileResponseModel: profileResponseModel ?? this.profileResponseModel,
    );
  }
}
