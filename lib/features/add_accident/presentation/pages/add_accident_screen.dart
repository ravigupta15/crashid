import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAccidentScreen extends StatefulWidget {
   static void open(BuildContext context) {
    context.push(AppRoutesPath.addAccidentScreen);
  }

  const AddAccidentScreen({super.key});

  @override
  State<AddAccidentScreen> createState() => _AddAccidentScreenState();
}

class _AddAccidentScreenState extends State<AddAccidentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
        title: "Add Accident",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications,
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
    );
  }

  
}