import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? onPressed;
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final bool? isShowAction;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    this.title,
    this.onPressed,
    this.leadingWidget,
    this.titleWidget,
    this.isShowAction = true,
    this.actions
  });
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      leadingWidth: leadingWidget != null ? null : 90,
      centerTitle: true,
      title:
          titleWidget ??
          Text(
            title ?? '',
            style: context.headlineMedium.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
      leading:
          leadingWidget ??
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onPressed ?? () => Navigator.pop(context),
            child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.blackColor,
                  size: 20,
                
            ),
          ),
      actions:  (isShowAction ?? false) ?  [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () => context.push(AppRoutesPath.notificationScreen),
              child: Icon(
                Icons.notifications,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ] : actions ?? [],
    );
  }
}
