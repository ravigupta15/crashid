import 'package:crashid/features/profile/model/profile_response_model.dart';

class ProfileState {
  final bool isLoading;
  final ProfileResponseModel? profileResponseModel;

  const ProfileState({
    required this.isLoading,
    this.profileResponseModel,
  });

  factory ProfileState.initial() {
    return const ProfileState(
      isLoading: false,
      profileResponseModel  : null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    ProfileResponseModel? profileResponseModel,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profileResponseModel: profileResponseModel ?? this.profileResponseModel,
    );
  }
}
