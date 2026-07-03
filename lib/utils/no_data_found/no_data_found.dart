import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final String? title;
  const NoDataFound({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text( title ?? AppLocalizations.of(context)!.noDataFound, 
      style: context.titleMedium.copyWith(color: AppColors.blackColor),),
    );
  }
}