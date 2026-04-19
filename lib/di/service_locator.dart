import 'package:crashid/data_sources/apis/base/dio_api_manager.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  static Future<void> init() async {
    _getIt.allowReassignment = true;

    /// User manager DI
    final userManager = UserManager();
    await userManager.init();
    _getIt.registerSingleton<UserManager>(userManager);

    /// Secure storage DI
    _getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());

    /// Dio API manager DI
    _getIt.registerLazySingleton<DioApiManager>(() => DioApiManager());
  }

  static T get<T extends Object>() => _getIt<T>();

  static void registerSingleton<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }

  static void reset() {
    _getIt.reset();
  }
}
