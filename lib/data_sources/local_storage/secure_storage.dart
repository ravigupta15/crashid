import 'package:crashid/data_sources/local_storage/share_preference_keys.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  late final FlutterSecureStorage storage;

  factory SecureStorage() => _instance;

  SecureStorage._internal() {
    storage = const FlutterSecureStorage();
    _clearOnFirstInstall(); // Call the clear logic once during init
  }

  Future<void> _clearOnFirstInstall() async {
    final prefs = await SharedPreferences.getInstance();
    final hasRunBefore = prefs.getBool('has_run_before') ?? false;

    if (!hasRunBefore) {
      await storage.deleteAll(); // Clear all secure storage
      await prefs.setBool('has_run_before', true);
    }
  }

  Future setUserToken(String token) async {
    await storage.write(
      key: SharePreferenceKeys.TOKEN.name,
      value: token,
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.unlocked),
    );
  }

  
  Future setRefreshToken(String token) async {
    await storage.write(
      key: SharePreferenceKeys.REFRESH_TOKEN.name,
      value: token,
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.unlocked),
    );
  }

  Future getUserToken() async {
    return await storage.read(
      key: SharePreferenceKeys.TOKEN.name,
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.unlocked),
    );
  }

  
  Future getRefreshToken() async {
    return await storage.read(
      key: SharePreferenceKeys.REFRESH_TOKEN.name,
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.unlocked),
    );
  }


  void clearValues() async {
    // final userManager = GetIt.I<UserManager>();
    await storage.deleteAll();
  }
}
