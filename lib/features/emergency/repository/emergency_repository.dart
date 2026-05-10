import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/features/emergency/add_emergency/model/add_emergency_send_model.dart';
import 'package:crashid/features/emergency/emergency/model/sos_send_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyRepository {
  final ApiService _apiService;

  EmergencyRepository(this._apiService);

  Future<Response?> searchApi(String? queryString) async{
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.searchUserUrl}?q=$queryString",
      method: ApiMethod.get,
    );
  }


  Future<Response?> addEmergency(AddEmergencySendModel? sendModel) async{
    return _apiService.sendRequest(
      apiUrl: ApiUrls.emergencyUrl,
      method: ApiMethod.post,
      data: sendModel?.toMap()
    );
  }


  Future<Response?> emergency() async{
    return _apiService.sendRequest(
      apiUrl: ApiUrls.emergencyUrl,
      method: ApiMethod.get,
    );
  }


  Future<Response?> sosEmergency(SosSendModel? sendModel) async{
    return _apiService.sendRequest(
      apiUrl: ApiUrls.sosUrl,
      method: ApiMethod.post,
      data: sendModel?.toMap()
    );
  }

  }

final emergencyRepositoryProvider = Provider((ref) {
  return EmergencyRepository(ApiService());
});
