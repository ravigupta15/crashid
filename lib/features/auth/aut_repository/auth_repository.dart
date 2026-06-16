import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/features/auth/forget_password/model/forget_send_model.dart';
import 'package:crashid/features/auth/otp/model/otp_send_model.dart';
import 'package:crashid/features/auth/registration/model/registration_send_model.dart';
import 'package:crashid/features/auth/reset_password/model/reset_password_send_model.dart';
import 'package:crashid/features/auth/signin/model/sign_in_model.dart';
import 'package:crashid/features/auth/signin/model/social_sign_in_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<Response?> login({SignInSendModel? model}) {
    return _apiService.sendRequest(
      apiUrl: _resolveUrl(ApiUrls.loginUrl),
      method: ApiMethod.post,
      data: model?.toMap(),
    );
  }

  Future<Response?> socialLogin({SocialSignInSendModel? model}) {
    print("Social login model: ${model?.toMap()}");
    return _apiService.sendRequest(
      apiUrl: _resolveUrl(ApiUrls.socialLoginUrl),
      method: ApiMethod.post,
      data: model?.toMap(),
    );
  }


  Future<Response?> forgotPassword({ForgetPasswordSendModel? model}) {
    return _apiService.sendRequest(
      apiUrl: _resolveUrl(ApiUrls.forgotPasswordUrl),
      method: ApiMethod.post,
      data: model?.toMap(),
    );
  }

  Future<Response?> verifyOtp({OtpSendModel? model}) {
    return _apiService.sendRequest(
      apiUrl: _resolveUrl(ApiUrls.verifyOtpUrl),
      method: ApiMethod.post,
      data: model?.toMap(),
    );
  }

  Future<Response?> resendOtp({OtpSendModel? model}) {
    return _apiService.sendRequest(
      apiUrl: _resolveUrl(ApiUrls.resendOtpUrl),
      method: ApiMethod.post,
      data: model?.toMap(),
    );
  }

  Future<Response?> resetPassword({ResetPasswordSendModel? model}) {
    return _apiService.sendRequest(
      apiUrl: _resolveUrl(ApiUrls.resetPasswordUrl),
      method: ApiMethod.post,
      data: model?.toMap(),
    );
  }
  
  Future<Response?> completeProfile({String? accountType}) async {
    final response = await ApiService().sendRequest(
      apiUrl: ApiUrls.completeProfileUrl,
      method: ApiMethod.post,
      data: FormData.fromMap({
        'account_type':accountType
      }),
    );
    return response;
  }
  
  Future<Response?> personalRegistration1({RegistrationSendModel? model}) async {
    if (model == null) throw Exception("Model is null");
    FormData formData = await model.toFormData();
    final response = await ApiService().sendRequest(
      apiUrl: ApiUrls.personalRegistrationUrl,
      method: ApiMethod.post,
      data: formData,
    );
    return response;
  }

  Future<Response?> companyRegistration({RegistrationSendModel? model}) {
    return _apiService.sendRequest(
      apiUrl: ApiUrls.companyRegistrationUrl,
      method: ApiMethod.post,
      data: model?.toCompanyMap()
    );
  }

  String _resolveUrl(String url) {
    if (url.startsWith('http')) return url;
    return '${ApiUrls.baseUrl}$url';
  }
}

// Create a provider for the repository
final authRepositoryProvider = Provider((ref) {
  return AuthRepository(ApiService());
});