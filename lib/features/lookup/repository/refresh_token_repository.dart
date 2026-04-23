
import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/apis/base/api_service.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/features/lookup/model/refresh_token_response_model.dart';
import 'package:crashid/utils/logout/app_logout.dart';
import 'package:get_it/get_it.dart';

class RefreshTokenRepository {
  static Future<bool>? _refreshingTokenFuture;

  static Future<bool> refreshTokenApi() async {
    if (_refreshingTokenFuture != null) {
      return await _refreshingTokenFuture!;
    }

    _refreshingTokenFuture = _refreshTokenInternal();

    try {
      return await _refreshingTokenFuture!;
    } catch (e) {
      // Log or handle error
      await AppLogoutHelper.logout();
      return false;
    } finally {
      _refreshingTokenFuture = null;
    }
  }

  static Future<bool> _refreshTokenInternal() async {
     final String? token = await GetIt.I<SecureStorage>().getRefreshToken();
    try {
      final data = {
        "refresh_token": token
      };

      final response = await ApiService().sendRequest(
        apiUrl: ApiUrls.refreshTokenUrl,
        method: ApiMethod.post,
        data: data,
        isErrorMessageShow: false,
      );

      if (response == null) {
        return false;
      }

      final statusCode = response.statusCode ?? 0;

      if (statusCode == 200) {
        var model = RefreshTokenResponseModel.fromJson(response.data);
         GetIt.I<SecureStorage>().setUserToken(model.data?.accessToken ?? '');
          GetIt.I<SecureStorage>().setRefreshToken(model.data?.refreshToken ?? '');        
          return true;
      }

     else if (statusCode == 401 ) {
        await AppLogoutHelper.logout();
      }
    } catch (e) {
      // Optional: log or report error
    }

    return false;
  }
}
