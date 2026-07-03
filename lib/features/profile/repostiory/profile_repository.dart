import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/features/profile/model/profile_send_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<Response?> getProfile() {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.profileUrl,
      method: ApiMethod.get,
    );
  }

  Future<Response?> updateProfileLanguage() async {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.profileUrl,
      method: ApiMethod.put,
      data: {"language": GetIt.I<UserManager>().language == 'de' ? 'de' : 'en'},
    );
  }

  Future<Response?> editProfile(ProfileSendModel? model) async {
    FormData formData =  model?.accountType == "personal" ? await  model!.toFormData(): await  model!.toCompanyMap();
    print(formData.fields);
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