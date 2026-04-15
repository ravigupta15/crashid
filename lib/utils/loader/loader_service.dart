import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoaderService {
  void showLoader() {
    AppRouter.mainNavigatorKey.currentContext!.loaderOverlay.show(
      widgetBuilder: (progress) {
        return LoaderWidget();
      },
    );
  }

  void hideLoader() {
    AppRouter.mainNavigatorKey.currentContext!.loaderOverlay.hide();
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget();

  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
}
