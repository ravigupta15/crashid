import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCarRepository {
  final ApiService _apiService;

  MyCarRepository(this._apiService);

  Future<Response?> myCar({String? searchQuery}) async {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.vehicleUrl,
      method: ApiMethod.get,
      queryParameters: searchQuery != null ? {'search': searchQuery} : null,
    );
  }

  Future<Response?> myCarDetails(String carId) async {
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.vehicleUrl}/$carId",
      method: ApiMethod.get,
    );
  }

  Future<Response?> deleteVehicle(String carId) async {
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.vehicleUrl}/$carId",
      method: ApiMethod.delete,
    );
  }
}

final myCarRepositoryProvider = Provider((ref) {
  return MyCarRepository(ApiService());
});
