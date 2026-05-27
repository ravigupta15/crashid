
import 'package:crashid/features/notification/model/notification_response_model.dart';

class NotificationState {
  final bool isLoading;
  final NotificationResponseModel? notificationResponseModel;

  const NotificationState({
    required this.isLoading,
    this.notificationResponseModel,
  });

  factory NotificationState.initial() {
    return const NotificationState(
      isLoading: false,
      notificationResponseModel  : null,
    );
  }

  NotificationState copyWith({
    bool? isLoading,
    NotificationResponseModel? notificationResponseModel,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      notificationResponseModel: notificationResponseModel ?? this.notificationResponseModel,
    );
  }
}
