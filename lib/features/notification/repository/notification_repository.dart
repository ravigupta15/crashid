import 'dart:io';

import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class NotificationRepository {
  final ApiService _apiService;

  NotificationRepository(this._apiService);
 
  Future<Response?> fcmToken() {
    var body = {
      "fcm_token": GetIt.I<UserManager>().fcmToken,
      "device_type": Platform.isAndroid ? "android" : "ios",
    };
    return _apiService.sendRequest(
      apiUrl: ApiUrls.fcmTokenUrl,
      method: ApiMethod.post,
      data: body, 
    );
  }


  Future<Response?> notification() {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.notificationUrl,
      method: ApiMethod.get
    );
  }

  
  Future<Response?> sosRespond({String? sosId, String? action}) {
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.sosUrl}/$sosId/respond",
      method: ApiMethod.post,
      data: {
        "action": action
      }
    );
  }
}

// Create a provider for the repository
final notificationRepositoryProvider = Provider((ref) {
  return NotificationRepository(ApiService());
});