import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';

class InternetConnectivity {
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkNetworkType() async {
    List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      showFeedbackMessage(AppLocalizations.of(AppRouter.mainNavigatorKey.currentContext!)!.noInternetConnection);
      print('No network connectivity (Wi-Fi, Mobile, etc.)');
      return false;
    } else {
      print('Device is connected to a network (may or may not have internet)');
      return true;
    }
  }
}
