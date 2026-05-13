import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/my_insurance/provider/insurance_notifier.dart';
import 'package:crashid/features/my_insurance/provider/insurane_state.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/no_data_found/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MyInsuranceScreen extends ConsumerStatefulWidget {
 
  static void open(BuildContext context) {
    context.push(AppRoutesPath.myInsuranceScreen);
  }

  const MyInsuranceScreen({super.key});

  @override
  ConsumerState<MyInsuranceScreen> createState() => _MyInsuranceScreenState();
}

class _MyInsuranceScreenState extends ConsumerState<MyInsuranceScreen> {

  final insurancetNotifier =
    AsyncNotifierProvider<InsuranceNotifier, InsuraneState>(InsuranceNotifier.new);


  
@override
  void initState() {
    _insuranceApi();
    super.initState();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Insurance",
        
      ),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    final refState = ref.watch(insurancetNotifier);
    var model = refState.value?.insuranceResponseModel?.data;

    return ColoredBox(
      color: AppColors.screenBackgroundCool,
      child: (model ?? []).isNotEmpty ?
       ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        itemCount: model?.length ?? 0,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          var items = model?[index];
          return _InsurancePolicyCard(
            companyName: items?.insuranceCompanyName,
            policyId: (items?.insuranceId ?? '').toString(),
            plateNumber: items?.plateNumber ,
            insuranceEmail: items?.insuranceEmail,
            isActive: true,
          );
        },
      ) : NoDataFound(),
    );
  }

  void _insuranceApi() {
    ref.read(insurancetNotifier.notifier).insuranceApi();
  }
}

class _InsurancePolicyCard extends StatelessWidget {
  final String companyName;
  final String policyId;
  final String plateNumber;
  final String insuranceEmail;
  final bool isActive;

  const _InsurancePolicyCard({
    required this.companyName,
    required this.policyId,
    required this.plateNumber,
    required this.insuranceEmail,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  companyName,
                  style: context.bodySmall.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                    height: 1.25,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (isActive) const _StatusBadge(label: 'Active'),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            policyId,
            style: context.bodySmall.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.insuranceMutedText,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _LabeledField(
                  label: 'Plate Number',
                  value: plateNumber,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _LabeledField(
                  label: 'Insurance Email',
                  value: insuranceEmail,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String label;

  const _StatusBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: context.bodySmall.copyWith(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String value;

  const _LabeledField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.bodySmall.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.insuranceMutedText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: context.bodySmall.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
