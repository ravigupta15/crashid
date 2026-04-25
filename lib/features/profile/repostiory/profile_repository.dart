import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/features/profile/model/profile_send_model.dart';
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

  Future<Response?> editProfile(ProfileSendModel? model) async {
    FormData formData = await model!.toFormData();
    return _apiService.sendRequest(
      apiUrl: ApiUrls.profileUrl,
      method: ApiMethod.put,
      data: formData,
    );
  }

}

// Create a provider for the repository
final profileRepositoryProvider = Provider((ref) {
  return ProfileRepository(ApiService());
});