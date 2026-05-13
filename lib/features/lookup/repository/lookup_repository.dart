import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LookupRepository {
  final ApiService _apiService;

  LookupRepository(this._apiService);

  Future<Response?> pageContentApi(String? slug) async{
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.contentUrl}/$slug",
      method: ApiMethod.get,
    );
  }
  
  Future<Response?> searchApi(String? queryString) async{
    return _apiService.sendRequest(
      apiUrl: "${ApiUrls.searchUserUrl}?q=$queryString",
      method: ApiMethod.get,
    );
  }
  }

final lookupRepositoryProvider = Provider((ref) {
  return LookupRepository(ApiService());
});
