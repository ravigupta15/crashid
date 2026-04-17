import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppDialogBox {
  openBox({
    VoidCallback? yesTap,
    String? title,
    String? subTitle,
    Widget? screenContent,
    Color? titleColor,
    String? leftBtnTitle,
    String? rightBtnTitle,
    double? maxWidthMinWidth
  }) {
    showGeneralDialog(
      context: AppRouter.mainNavigatorKey.currentContext!,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            constraints:   BoxConstraints(maxWidth: maxWidthMinWidth ?? 340, minWidth: maxWidthMinWidth ?? 340),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child:
                screenContent ??
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 20,
                    right: 20,
                    bottom: 33,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title ?? '',
                        style: AppRouter
                            .mainNavigatorKey
                            .currentContext!
                            .titleMedium
                            .copyWith(fontSize: 16, color: titleColor),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        subTitle ?? '',
                        style: AppRouter
                            .mainNavigatorKey
                            .currentContext!
                            .titleMedium
                            .copyWith(fontSize: 14),
                      ),

                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: AppElevatedButton.withTitle(
                              title: leftBtnTitle ?? "No",
                              onPressed: () {
                                Navigator.pop(
                                  AppRouter.mainNavigatorKey.currentContext!,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AppElevatedButton.withTitle(
                              title: rightBtnTitle ?? "Yes",
                              onPressed: yesTap,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
  }
}
