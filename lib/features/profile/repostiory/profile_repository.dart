import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/features/auth/forget_password/model/forget_send_model.dart';
import 'package:crashid/features/auth/otp/model/otp_send_model.dart';
import 'package:crashid/features/auth/registration/model/registration_send_model.dart';
import 'package:crashid/features/auth/reset_password/model/reset_password_send_model.dart';
import 'package:crashid/features/auth/signin/model/sign_in_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<Response?> getProfile() {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.profileUrl,
      method: ApiMethod.get,
    );
  }

}

// Create a provider for the repository
final profileRepositoryProvider = Provider((ref) {
  return ProfileRepository(ApiService());
});