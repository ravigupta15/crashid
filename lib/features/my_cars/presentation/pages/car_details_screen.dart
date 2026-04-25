import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/my_cars/presentation/widgets/car_detail_info_row_widget.dart';
import 'package:crashid/features/my_cars/provider/my_car_notifier.dart';
import 'package:crashid/features/my_cars/provider/my_car_state.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:crashid/utils/linkers/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CarDetailsScreen extends ConsumerStatefulWidget {
  static const String kId = "kId";

  final String? id;
  static void open(BuildContext context, String? id) {
    context.push(AppRoutesPath.carDetailsScreen, extra: {kId: id});
  }

  const CarDetailsScreen({super.key, this.id});

  @override
  ConsumerState<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends ConsumerState<CarDetailsScreen> {
  

  
final myCarNotifierProvider =
    AsyncNotifierProvider<MyCarNotifier, MyCarState>(MyCarNotifier.new);

    @override
  void initState() {
    _callMyCarDetailsApi();
    super.initState();
   }

  void _callMyCarDetailsApi() async{
     await ref.read(myCarNotifierProvider.notifier).myCarDetails(widget.id ?? '');
  }

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
    final refState = ref.watch(myCarNotifierProvider);
    final model = refState.value?.carDetailsResponseModel?.data;
    return model != null ? ColoredBox(
      color: AppColors.screenBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Container(
          padding: EdgeInsets.only(bottom: 20),
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
              child: AppCachedNetworkImage(imageUrl: model.images?.first.imageUrl ?? '', height: 200, boxFit: BoxFit.cover,),
              //  SizedBox(
              //   height: 200,
              //   child: Image.asset(
              //     "assets/images/dummy_car (2).png",
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            const SizedBox(height: 20),
             CarDetailInfoRow(label: 'Brand', value: model.brand ?? '-'),
            const SizedBox(height: 20),
             CarDetailInfoRow(label: 'Model', value: model.model ?? '-'),
            const SizedBox(height: 20),
             CarDetailInfoRow(label: 'Car Name', value: model.carName ?? ''),
            const SizedBox(height: 20),
             CarDetailInfoRow(label: 'Fuel Type', value: model.fuelType ?? '-'),
            const SizedBox(height: 20),
             CarDetailInfoRow(
              label: 'Registration Date',
              value: AppDateFormat.formatDate(model.registrationDate),
            ),
            const SizedBox(height: 20),
             CarDetailInfoRow(label: 'Color', value: model.color ?? '-'),
            const SizedBox(height: 20),
             CarDetailInfoRow(
              label: 'FIN/VIN',
              value: model.finVin ?? '-',
            ),
            const SizedBox(height: 20),
             CarDetailInfoRow(
              label: 'Insurance Company',
              value: model.insuranceCompanyName ?? '-',
            ),
            const SizedBox(height: 20),
             CarDetailInfoRow(
              label: 'Insurance Number',
              value: model.insuranceNumber ?? '-',
            ),
            const SizedBox(height: 20),
             CarDetailInfoRow(
              label: 'Insurance Expiry',
              value: AppDateFormat.formatDate(model.validUntil),
            ),
            if ((model.insuranceImage ?? '').isNotEmpty)...[
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _InsurancePdfCard(
                date: AppDateFormat.formatMonthYear(model.createdAt),
                onView: () {
                  LaunchURLUtils().launchStringURL(model.insuranceImage ?? '');
                },
              ),
            ),
            ]
          ],
        ),
      ),
      ),
    ) : EmptyWidget();
  }
}

class _InsurancePdfCard extends StatelessWidget {
  final VoidCallback onView;
  final String? date;

  const _InsurancePdfCard({required this.onView, this.date});


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
                  'Last updated: ${date ?? ''}',
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
