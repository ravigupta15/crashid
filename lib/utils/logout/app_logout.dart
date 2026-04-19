import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AppLogoutHelper {
  static Future<void> logout() async {
    GetIt.I<SecureStorage>().clearValues();
    AppRouter.mainNavigatorKey.currentContext!.go(AppRoutesPath.signinScreen);
  }
}
