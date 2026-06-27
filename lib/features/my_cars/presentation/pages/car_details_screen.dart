import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/my_cars/presentation/widgets/car_detail_info_row_widget.dart';
import 'package:crashid/features/my_cars/provider/my_car_notifier.dart';
import 'package:crashid/features/my_cars/provider/my_car_state.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:crashid/utils/linkers/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CarDetailsScreen extends ConsumerStatefulWidget {
  static const String kId = "kId";

  final String? id;
  static Future<void> open(BuildContext context, String? id) {
    return context.push(AppRoutesPath.carDetailsScreen, extra: {kId: id});
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
    Future.microtask(() => _callMyCarDetailsApi());
    super.initState();
  }

  void _callMyCarDetailsApi() async {
    await ref
        .read(myCarNotifierProvider.notifier)
        .myCarDetails(widget.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.carDetailsTitle),

      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    final refState = ref.watch(myCarNotifierProvider);
    final model = refState.value?.carDetailsResponseModel?.data;
    return model != null
        ? ColoredBox(
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
                      child: AppCachedNetworkImage(
                        imageUrl: model.images?.first.imageUrl ?? '',
                        height: 200,
                        boxFit: BoxFit.cover,
                        canOpenImage: true,
                      ),
                      //  SizedBox(
                      //   height: 200,
                      //   child: Image.asset(
                      //     "assets/images/dummy_car (2).png",
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(label: AppLocalizations.of(context)!.brand, value: model.brand ?? '-'),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(label: AppLocalizations.of(context)!.model, value: model.model ?? '-'),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.carName,
                      value: model.carName ?? '',
                    ),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.fuelType,
                      value: model.fuelType ?? '-',
                    ),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.registrationDate,
                      value: AppDateFormat.formatDate(model.registrationDate),
                    ),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(label: AppLocalizations.of(context)!.color, value: model.color ?? '-'),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.finVin,
                      value: model.finVin ?? '-',
                    ),const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.hpPs,
                      value: (model.hpPs ?? '-').toString(),
                    ),const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.mileageKm,
                      value: (model.mileageKm ?? '-').toString(),
                    ),const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.tuvDate,
                      value: AppDateFormat.formatDate(model.tuevDate ?? ''),
                    ),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.insuranceCompany,
                      value: model.insuranceCompanyName ?? '-',
                    ),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.insuranceNumber,
                      value: model.insuranceNumber ?? '-',
                    ),
                    const SizedBox(height: 20),
                    CarDetailInfoRow(
                      label: AppLocalizations.of(context)!.insuranceExpiry,
                      value: AppDateFormat.formatDate(model.validUntil),
                    ),
                    if ((model.insuranceImage ?? '').isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _InsurancePdfCard(
                          date: AppDateFormat.formatMonthYear(model.createdAt),
                          onView: () {
                            print(model.insuranceImageUrl ?? '');
                            LaunchURLUtils().launchStringURL(
                              model.insuranceImageUrl ?? '',
                            );
                          },
                        ),
                      ),
                    ],
                    if ((model.tuevDocumentUrl ?? '').isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _InsurancePdfCard(
                          date: AppDateFormat.formatMonthYear(model.createdAt),
                          onView: () {
                            print(model.tuevDocumentUrl ?? '');
                            LaunchURLUtils().launchStringURL(
                              model.tuevDocumentUrl ?? '',
                            );
                          },
                        ),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(top: 19),
                      child: Divider(color: Color(0xffF6F7F9)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: _openDialogBox,
                        child: Image.asset(
                          AppAssetPaths.deleteIcon,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : EmptyWidget();
  }

  void _openDialogBox() {
    AppDialogBox().openBox(
      
    maxWidthMinWidth: MediaQuery.of(context).size.width * .8,
      title: AppLocalizations.of(context)!.deleteCarTitle,
      subTitle: AppLocalizations.of(context)!.deleteCarConfirmation,
      yesTap: () {
        Navigator.pop(context);
        _deleteMyVehicle();
      },
    );
  }

  void _deleteMyVehicle() async {
    await ref
        .read(myCarNotifierProvider.notifier)
        .deleteMyVehicle(widget.id ?? '')
        .then((response) {
          if (response?.statusCode == 200 || response?.statusCode == 201) {
            Navigator.pop(context);
          }
        });
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
                  AppLocalizations.of(context)!.insurancePdf,
                  style: context.bodySmall.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkGrayColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                   '${AppLocalizations.of(context)!.lastUpdated}: ${date ?? ''}',
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
