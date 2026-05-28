import 'dart:async';
import 'package:crashid/features/notification/model/notification_response_model.dart';
import 'package:crashid/features/notification/provider/notification_state.dart';
import 'package:crashid/features/notification/repository/notification_repository.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

 
final notificationProvider =
    AsyncNotifierProvider<NotificationNotifier, NotificationState>(NotificationNotifier.new);

   
class NotificationNotifier extends AsyncNotifier<NotificationState> {
  @override
  FutureOr<NotificationState> build() {
    return NotificationState.initial();
  }


  Future<void> fcmToken() async {
    try {
      final repo = ref.read(notificationRepositoryProvider);
      final response = await repo.fcmToken();
      if (response?.statusCode == 200 ) {
      }
    } catch (_) {
    }
     finally {
    }
  }
  Future<void> getNotificationn() async {
    try {
      LoaderService().showLoader();
       state = AsyncData(state.value!.copyWith(
          notificationResponseModel: NotificationResponseModel.fromJson({}),
        ));
      final repo = ref.read(notificationRepositoryProvider);
      final response = await repo.notification();
      if (response?.statusCode == 200 ) {
        state = AsyncData(state.value!.copyWith(
          notificationResponseModel: NotificationResponseModel.fromJson(response?.data),
        ));
      }
    } catch (_) {
    }
     finally {
      LoaderService().hideLoader();
    }
  }

  Future<void> sosRespond({String? sosId, String? action}) async {
    try {
      LoaderService().showLoader();
      final repo = ref.read(notificationRepositoryProvider);
      final response = await repo.sosRespond(sosId: sosId, action: action);
      if (response?.statusCode == 200 ) {
        getNotificationn();
      }
    } catch (_) {
    }
     finally {
      LoaderService().hideLoader();
    }
  }
  
}

