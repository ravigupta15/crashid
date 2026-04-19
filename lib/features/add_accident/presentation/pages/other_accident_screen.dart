import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/add_accident/presentation/widgets/accident_details_widget.dart';
import 'package:crashid/features/add_accident/presentation/widgets/payment_method_widget.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OtherAccidentScreen extends StatefulWidget {
 
  static void open(BuildContext context) {
    context.push(AppRoutesPath.otherAccidentScreen);
  }

  const OtherAccidentScreen({super.key});

  @override
  State<OtherAccidentScreen> createState() => _OtherAccidentScreenState();
}

class _OtherAccidentScreenState extends State<OtherAccidentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Accident",
   
      ),
      body: _screenContent(),
    );
  }
  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------
 
 Widget _screenContent() {
  return SingleChildScrollView(
     padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
 Text("Other Driver",
        style: context.titleMedium.copyWith(
          fontSize: 14, fontWeight: FontWeight.w700),
        ),
        
        const SizedBox(height: 5,),
        AppTextFormField(
          hintText: "ABC-1234",
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 13),
        child: Divider(
          color: AppColors.blackColor.withValues(alpha: .2),  
        ),
        ),
 Text("Witness",
        style: context.titleMedium.copyWith(
          fontSize: 14, fontWeight: FontWeight.w700),
        ),
        
        const SizedBox(height: 5,),
        AppTextFormField(
          hintText: "ABC-1234",
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 13),
        child: Divider(
          color: AppColors.blackColor.withValues(alpha: .2),  
        ),
        ),
        AccidentDetailsWidget(),
        PaymentMethodWidget(),
        const SizedBox(height: 33,),
        Center(child:
         AppElevatedButton.withTitle(title: "Add Accident", onPressed: (){},))
      ],
    ),
  );
 }


}