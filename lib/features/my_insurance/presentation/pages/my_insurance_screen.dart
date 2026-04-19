import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyInsuranceScreen extends StatefulWidget {
 
  static void open(BuildContext context) {
    context.push(AppRoutesPath.myInsuranceScreen);
  }

  const MyInsuranceScreen({super.key});

  @override
  State<MyInsuranceScreen> createState() => _MyInsuranceScreenState();
}

class _MyInsuranceScreenState extends State<MyInsuranceScreen> {
  static const List<_InsurancePolicyData> _policies = [
    _InsurancePolicyData(
      companyName: 'KOTAK GENERAL CAR INSURANCE',
      policyId: 'KG7 MFCD2CCD 974271',
      plateNumber: 'A BC 1234',
      insuranceEmail: 'Rohitsolanki1814@gmail.com',
      isActive: true,
    ),
    _InsurancePolicyData(
      companyName: 'HDFC ERGO MOTOR INSURANCE',
      policyId: 'HDFC MOTOR 882910 441902',
      plateNumber: 'MH 12 AB 9012',
      insuranceEmail: 'policyholder@example.com',
      isActive: true,
    ),
  ];

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
    return ColoredBox(
      color: AppColors.screenBackgroundCool,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        itemCount: _policies.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final policy = _policies[index];
          return _InsurancePolicyCard(
            companyName: policy.companyName,
            policyId: policy.policyId,
            plateNumber: policy.plateNumber,
            insuranceEmail: policy.insuranceEmail,
            isActive: policy.isActive,
          );
        },
      ),
    );
  }
}

class _InsurancePolicyData {
  final String companyName;
  final String policyId;
  final String plateNumber;
  final String insuranceEmail;
  final bool isActive;

  const _InsurancePolicyData({
    required this.companyName,
    required this.policyId,
    required this.plateNumber,
    required this.insuranceEmail,
    required this.isActive,
  });
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
              fontWeight: FontWeight.w500,
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
            fontWeight: FontWeight.w500,
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
