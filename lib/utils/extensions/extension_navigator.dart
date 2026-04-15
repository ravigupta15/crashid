import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigatorStateExtension on NavigatorState {
  Future<dynamic> pushNamedOrReplacementIfCurrent(String routeName,
      {Object? arguments}) async {
    if (isCurrent(routeName)) {
      return pushReplacementNamed(routeName, arguments: arguments);
    } else {
      return pushNamed(routeName, arguments: arguments);
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}

extension NavigatorExt on BuildContext {
  /// Performs a [GoRouter.of(context).pushNamedAndRemoveUntil] action with given [routeName]
  Future<dynamic> pushNamedAndRemoveUntil(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) async {
    while (canPop()) {
      pop();
    }
    pushReplacement(
      name,
      extra: extra,
    );
  }
}
