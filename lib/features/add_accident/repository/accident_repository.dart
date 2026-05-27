import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/features/add_accident/model/add_accident_send_model.dart';
import 'package:crashid/features/add_accident/model/other_accident_send_model.dart';
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

  
  Future<Response?> caseDetails({String? caseId}) {
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.accidentsUrl}/$caseId",
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
  
  Future<Response?> completeAccident(OtherAccidentSendModel? sendModel) async{
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.accidentsUrl}/${sendModel?.caseId}/complete",
      method: ApiMethod.put,
      data: sendModel?.toMap()
    );
  }


  Future<Response?> paymentCapture({String? caseId, String? paypalOrderId}) async{
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.accidentsUrl}/$caseId/payment/capture",
      method: ApiMethod.post,
      data: {
        "paypal_order_id": paypalOrderId
      }
    );
  }
  
  Future<Response?> caseClosed({String? caseId}) async{
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.accidentsUrl}/$caseId/close",
      method: ApiMethod.put,
    );
  }

  
  Future<Response?> userBReject({String? caseId}) async{
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.accidentsUrl}/$caseId/b-reject",
      method: ApiMethod.post,
    );
  }

  
  Future<Response?> userBAccept({AddAccidentSendModel? sendModel}) async{
      FormData formData = await sendModel!.userBFormData();
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.accidentsUrl}/${sendModel.caseId}/respond",
      method: ApiMethod.post,
      data: formData
    );
  }
  
  Future<Response?> witnessResponse({AddAccidentSendModel? sendModel}) async{
    FormData formData = await sendModel!.userCFormData();
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.accidentsUrl}/${sendModel.caseId}/witness-respond",
      method: ApiMethod.post,
      data: formData
    );
  }
}
// Create a provider for the repository
final accidentRepositoryProvider = Provider((ref) {
  return AccidentRepository(ApiService());
});