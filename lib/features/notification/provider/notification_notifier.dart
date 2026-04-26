import 'dart:async';
import 'package:crashid/features/notification/provider/notification_state.dart';
import 'package:crashid/features/notification/repository/notification_repository.dart';
import 'package:crashid/utils/loader/loader_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationNotifier extends AsyncNotifier<NotificationState> {
  @override
  FutureOr<NotificationState> build() {
    return NotificationState.initial();
  }

  Future<void> getNotificationn(BuildContext context) async {
    try {
      LoaderService().showLoader();
      final repo = ref.read(notificationRepositoryProvider);
      final response = await repo.notification();
      if (response?.statusCode == 200 ) {
      }
    } catch (_) {
    }
     finally {
      LoaderService().hideLoader();
    }
  }
  
}

