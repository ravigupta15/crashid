import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InsuranceRepository {
  final ApiService _apiService;

  InsuranceRepository(this._apiService);

  Future<Response?> insurance() {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.insuranceUrl,
      method: ApiMethod.get,
    );
  }
}

// Create a provider for the repository
final insuranceRepositoryProvider = Provider((ref) {
  return InsuranceRepository(ApiService());
});