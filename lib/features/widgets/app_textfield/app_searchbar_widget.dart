import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSearchWidget extends StatefulWidget {
  final void Function(String) searchClackedCallBack;
  final TextEditingController controller;
  final int minSearchLength;
  final Color? backgroundColor;
  final String? hintText;
  final Widget? suffixIcon;
  final bool? isReadOnly;
  final Function()? onTap;
  const AppSearchWidget(
      {super.key,
      required this.searchClackedCallBack,
      required this.controller,
      this.minSearchLength = 2,
      this.backgroundColor,
      this.hintText,
      this.suffixIcon,
      this.isReadOnly,
      this.onTap});

  @override
  State<AppSearchWidget> createState() => _AppSearchWidgetState();
}

class _AppSearchWidgetState extends State<AppSearchWidget> {
  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      onTap: widget.onTap,
      controller: widget.controller,
      isReadOnly: widget.isReadOnly ?? false,
      formFieldFill: widget.backgroundColor,
      hintText: widget.hintText ?? "Search...",
      hintTextStyle:  context.bodyMedium.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGrayColor.withValues(alpha: .6),
                ), 
      prefixIcon: Image.asset(
        AppAssetPaths.searchIcon,
        height: 16,
        width: 16,
        fit: BoxFit.scaleDown,
      ),
      suffixIcon: widget.suffixIcon != null
          ? widget.suffixIcon!
          : widget.controller.text.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.controller.clear();
                      widget.searchClackedCallBack(widget.controller.text);
                    });
                  },
                  child: Icon(Icons.clear))
              : null,
      onChanged: (value) {
        if (value.isNullOrEmpty) {
          widget.searchClackedCallBack(value);
        } 
        else if (value.length >= widget.minSearchLength) {
          widget.searchClackedCallBack(value);
        }
        setState(() {});
      },
      onFieldSubmitted: (value) {
        widget.searchClackedCallBack(value ?? "");
      },
      textInputAction: TextInputAction.search,
    );
  }
}
