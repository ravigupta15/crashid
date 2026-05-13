import 'dart:convert';
import 'dart:developer';

import 'package:crashid/core/service/internet_connectivity.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/features/lookup/repository/refresh_token_repository.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/logout/app_logout.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

enum ApiMethod { get, post, put, delete }

class ApiService {
  Future<Response?> sendRequest({
    required String apiUrl,
    required ApiMethod method,
    var data,
    Map<String, dynamic>? queryParameters,
    bool isErrorMessageShow = true,
    bool retry = true, // Prevent infinite loop
  }) async {
    Dio dio = Dio();
    final headers = await getAuthHeaders();
    Options options = Options(method: method.name, headers: headers);

    try {
      bool isConnected = await InternetConnectivity.isConnected();
      if (!isConnected) {
        showFeedbackMessage("No internet connection");
        return null;
      }
      
     print(data);
     print(apiUrl);
      final response = await dio.request(
        apiUrl,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return _processResponse(response, isErrorMessageShow);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401  && retry) {
        // Refresh token
          final refreshed = await RefreshTokenRepository.refreshTokenApi();
        if (refreshed) {
          return sendRequest(
            apiUrl: apiUrl,
            method: method,
            data: data,
            queryParameters: queryParameters,
            isErrorMessageShow: isErrorMessageShow,
            retry: false, // only retry once
          );
        } else {
          showFeedbackMessage("Session expired. Please log in again.");
          AppLogoutHelper.logout();
        }
      } else if (e.response != null) {
        _processResponse(e.response!, isErrorMessageShow);
      } else {
        showFeedbackMessage("Something went wrong");
      }
      return null;
    }
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final String? token = await GetIt.I<SecureStorage>().getUserToken();
    print("token...$token");
    return {
      if (token.isNotNullOrNotEmpty) 'Authorization': "Bearer $token",
    };
  }

  Response? _processResponse(Response response, bool showErrorMessage) {
    print("Status: ${response.statusCode}");
    log(json.encode(response.data));

    if (response.statusCode == 201 || response.statusCode == 200) return response;
     if(response.statusCode == 401){
      showFeedbackMessage(response.data['message'].toString());
      AppLogoutHelper.logout();
     } else if (showErrorMessage && response.data['message'] != null) {
      showFeedbackMessage(response.data['message'].toString());
    }

    return null;
  }
}
