import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationRepository {
  final ApiService _apiService;

  NotificationRepository(this._apiService);

  Future<Response?> notification() {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.notificationUrl,
      method: ApiMethod.get
    );
  }
}

// Create a provider for the repository
final notificationRepositoryProvider = Provider((ref) {
  return NotificationRepository(ApiService());
});