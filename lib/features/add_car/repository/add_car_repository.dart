import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/features/add_car/model/add_car_send_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddCarRepository {
  final ApiService _apiService;

  AddCarRepository(this._apiService);

Future<Response?> carBrands() async{
    return _apiService.sendRequest(
      apiUrl: ApiUrls.carBrandsUrl,
      method: ApiMethod.get,
    );
  }

  Future<Response?> carModels({AddCarSendModel? model}) async{
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.carBrandsUrl}/${model?.brand}/models",
      method: ApiMethod.get,
    );
  }

  Future<Response?> carColors() async{
    return _apiService.sendRequest(
      apiUrl: ApiUrls.carColorUrl,
      method: ApiMethod.get,
    );
  }

  Future<Response?> insurance() async {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.insuranceUrl,
      method: ApiMethod.get,
    );
  }

  Future<Response?> addCar({AddCarSendModel? model}) async{
    FormData formData = await model!.toFormData();
     print(formData.fields);
    return _apiService.sendRequest(
      apiUrl: ApiUrls.vehicleUrl,
      method: ApiMethod.post,
      data: formData,
    );
  }
}

final addCarRepositoryProvider = Provider((ref) {
  return AddCarRepository(ApiService());
});
