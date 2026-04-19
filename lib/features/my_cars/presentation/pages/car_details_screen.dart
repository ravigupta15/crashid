import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/my_cars/presentation/widgets/car_detail_info_row_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarDetailsScreen extends StatefulWidget {
  
  static void open(BuildContext context) {
    context.push(AppRoutesPath.carDetailsScreen);
  }

  const CarDetailsScreen({super.key});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
        title: "Car Details",
      
      ),
    
      body: _screenContent()
    );
  }

   // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return ColoredBox(
      color: AppColors.screenBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: SizedBox(
                height: 200,
                child: Image.asset(
                  "assets/images/dummy_car (2).png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const CarDetailInfoRow(label: 'Brand', value: 'Volkswagen'),
            const SizedBox(height: 20),
            const CarDetailInfoRow(label: 'Model', value: 'Zxi'),
            const SizedBox(height: 20),
            const CarDetailInfoRow(label: 'Car Name', value: 'Ameo'),
            const SizedBox(height: 20),
            const CarDetailInfoRow(label: 'Fuel Type', value: 'Petrol'),
            const SizedBox(height: 20),
            const CarDetailInfoRow(
              label: 'Registration Date',
              value: '14/12/1998',
            ),
            const SizedBox(height: 20),
            const CarDetailInfoRow(label: 'Color', value: 'Metal Grey'),
            const SizedBox(height: 20),
            const CarDetailInfoRow(
              label: 'FIN/VIN',
              value: '1HGBH41JXMN109186',
            ),
            const SizedBox(height: 20),
            const CarDetailInfoRow(
              label: 'Insurance Company',
              value: 'Yes Bank',
            ),
            const SizedBox(height: 20),
            const CarDetailInfoRow(
              label: 'Insurance Number',
              value: '123456789',
            ),
            const SizedBox(height: 20),
            const CarDetailInfoRow(
              label: 'Insurance Expiry',
              value: '14/12/2026',
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _InsurancePdfCard(
                onView: () {},
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class _InsurancePdfCard extends StatelessWidget {
  final VoidCallback onView;

  const _InsurancePdfCard({required this.onView});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.documentIconBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.picture_as_pdf_rounded,
              color: AppColors.primaryColor,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Insurance PDF',
                  style: context.bodySmall.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGrayColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Last updated: Oct 2023',
                  style: context.bodySmall.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkGrayColor.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onView,
            child: Icon(
                Icons.visibility_outlined,
                color: AppColors.darkGrayColor.withValues(alpha: 0.55),
              
            ),
          ),
        ],
      ),
    );
  }
}
