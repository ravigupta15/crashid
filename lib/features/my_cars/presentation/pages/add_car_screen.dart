import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/app_textfield/custom_dropdown_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddCarScreen extends StatefulWidget {

  static void open(BuildContext context) {
    context.push(AppRoutesPath.addCarScreen);
  }

  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.addCarTitle ,
      ),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      child: Column(
        children: [
         AppTextFormField(
          hintText: "Plate Number",
         ),
          const SizedBox(height: 20),
          CustomDropDownFormFiledWidget(
            hintText: "Brand",
          ),
          const SizedBox(height: 20),
          CustomDropDownFormFiledWidget(
            hintText: "Model",
          ),
          const SizedBox(height: 20),
          CustomDropDownFormFiledWidget(
            hintText: "Car Name",
          ),
          const SizedBox(height: 20),
          CustomDropDownFormFiledWidget(
            hintText: "Fuel Type",
          ),
          const SizedBox(height: 20),
          CustomDropDownFormFiledWidget(
            hintText: "Registration date from",
          ),
          const SizedBox(height: 20),
          CustomDropDownFormFiledWidget(
            hintText: "Color",
          ),
          const SizedBox(height: 20),
          AppTextFormField(
            hintText: 'FIN/VIN',
          ),
          const SizedBox(height: 20),
          _buildUploadField('Car Image'),
          const SizedBox(height: 20),
          AppTextFormField(hintText: "Insurance Company",),
          const SizedBox(height: 20),
          AppTextFormField(
            hintText: 'Insurance Number',
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  hintText: 'dd/mm/yy',
                  textColor: AppColors.darkGrayColor,
                  isReadOnly: true,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '—',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor.withValues(alpha: .5),
                    ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppTextFormField(
                  hintText: 'dd/mm/yy',
                  textColor: AppColors.darkGrayColor,
                  isReadOnly: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildUploadField('Insurance PDF'),
          const SizedBox(height: 20),
          AppElevatedButton.withTitle(
            title: AppLocalizations.of(context)!.addCarTitle,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
  Widget _buildUploadField(String title) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: context.bodyMedium.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGrayColor.withValues(alpha: .6),
               ),
            ),
          ),
          Center(
            child: Image.asset(
              AppAssetPaths.uploadIcon,
              width: 50,
              height: 38,
            ),
          ),
        ],
      ),
    );
  }
}
