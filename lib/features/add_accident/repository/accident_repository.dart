import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/features/add_accident/model/add_accident_send_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccidentRepository {
  final ApiService _apiService;

  AccidentRepository(this._apiService);

  Future<Response?> caseHistory({String? currentTab}) {
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.accidentsUrl}?tab=$currentTab",
      method: ApiMethod.get,
    );
  }

  
  Future<Response?> pricing() {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.pricingUrl,
      method: ApiMethod.get,
    );
  }

  
  Future<Response?> addAccident(AddAccidentSendModel? sendModel) async{
     FormData formData = await sendModel!.toFormData();
   
    return _apiService.sendRequest(
      apiUrl: ApiUrls.accidentsUrl,
      method: ApiMethod.post,
      data: formData
    );
  }
}
// Create a provider for the repository
final accidentRepositoryProvider = Provider((ref) {
  return AccidentRepository(ApiService());
});