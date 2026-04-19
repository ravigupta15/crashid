import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/dio_api_manager.dart';
import 'package:crashid/features/auth/signin/model/sign_in_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class AuthRepository {
  final Dio _dio;

  // Inject the specific dio instance here
  AuthRepository(this._dio);

  Future<Response> login({SignInSendModel? model}) {
    return _dio.post(ApiUrls.login, data: model?.toMap());
  }
}

// Create a provider for the repository
final authRepositoryProvider = Provider((ref) {
  final dio = GetIt.I<DioApiManager>().dioUnauthorized;
  return AuthRepository(dio);
});