import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
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
}
// Create a provider for the repository
final accidentRepositoryProvider = Provider((ref) {
  return AccidentRepository(ApiService());
});