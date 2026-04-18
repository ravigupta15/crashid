import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/app_textfield/custom_dropdown_widget.dart';
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
      body: _screenContent(),
    );
  }

  
  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------
 
 Widget _screenContent() {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select own plate number",
        style: context.titleMedium.copyWith(
          fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5,),
        CustomDropDownFormFiledWidget( 
          borderRadius: 10,
          enableBorderColor: AppColors.blackColor,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 13),
        child: Divider(
          color: AppColors.blackColor.withValues(alpha: .2),  
        ),
        ),
        Text("Text Description",  style: context.titleMedium.copyWith(
          fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5,),
        AppTextFormField(
          borderRadius: 10,
          hintText: "Describe what happened...",
          maxLines: 3,
        ),
          Padding(padding: EdgeInsets.symmetric(vertical: 13),
        child: Divider(
          color: AppColors.blackColor.withValues(alpha: .2),  
        ),
        ),
      Text("Upload up to 5 Images", style: context.titleMedium.copyWith(
        fontSize: 14, fontWeight: FontWeight.w700
      ),),
      
      ],
    ),
  );
 }
}