import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Function()? onPressed;
  final Widget? leadingWidget;
  final List<Widget>? actions;
  final Widget? titleWidget;
  const CustomAppBar({
    super.key,
    this.title,
    this.onPressed,
    this.leadingWidget,
    this.actions,
    this.titleWidget,
  });
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      leadingWidth: leadingWidget != null ? null : 90,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child:  Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.blackColor,
                    size: 20,
                  
              ),
            ),
          ),
      actions: actions,
    );
  }
}
