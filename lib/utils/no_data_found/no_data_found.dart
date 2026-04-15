import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  final String? title;
  const NoDataFound({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: AppText(title: title ?? 'No data found', color: AppColors.redColor,fontFamily: AppFontFamily.medium,),
    );
  }
}