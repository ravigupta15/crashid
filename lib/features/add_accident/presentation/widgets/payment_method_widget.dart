import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

enum PaymentMethodKind { paypal, creditCard }

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({
    super.key,
    this.serviceCharge = 15,
    this.vat = 2,
    this.onMethodChanged,
  });

  final double serviceCharge;
  final double vat;
  final ValueChanged<PaymentMethodKind>? onMethodChanged;

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  PaymentMethodKind _selected = PaymentMethodKind.paypal;


  void _select(PaymentMethodKind kind) {
    if (_selected == kind) return;
    setState(() => _selected = kind);
    widget.onMethodChanged?.call(kind);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Payment Method',
          style: context.titleMedium.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(height: 12),
        _paymentSelector(context),
        const SizedBox(height: 20),
        _priceSummaryRow(
          context,
          label: 'Service Charge',
          value: _euro(widget.serviceCharge),
        ),
        const SizedBox(height: 12),
        _priceSummaryRow(
          context,
          label: 'VAT',
          value: _euro(widget.vat),
        ),
        const SizedBox(height: 12),
        _priceSummaryRow(
          context,
          label: 'Total Amount',
          value: _euro(17),
        ),
      ],
    );
  }

  String _euro(double amount) {
    final s = amount == amount.roundToDouble()
        ? amount.toStringAsFixed(0)
        : amount.toStringAsFixed(2);
    return '€$s';
  }

  Widget _paymentSelector(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            Expanded(
              child: _paymentChip(
                context,
                selected: _selected == PaymentMethodKind.paypal,
                onTap: () => _select(PaymentMethodKind.paypal),
                child: Center(
                  child: Image.asset(
                    AppAssetPaths.paypalIcon,
                    // height: 28,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _paymentChip(
                context,
                selected: _selected == PaymentMethodKind.creditCard,
                onTap: () => _select(PaymentMethodKind.creditCard),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssetPaths.creditCardIcon,
                      height: 28,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Credit Card',
                      textAlign: TextAlign.center,
                      style: context.titleMedium.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentChip(
    BuildContext context, {
    required bool selected,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          height: 78,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.whiteColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.blackColor.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _priceSummaryRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.bodyLarge.copyWith(
            fontSize: 14,
            fontWeight:  FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
        Text(
          value,
          style: context.bodyLarge.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }
}
