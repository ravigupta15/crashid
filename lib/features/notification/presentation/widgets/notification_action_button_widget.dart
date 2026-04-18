import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';

class NotificationActionButtonWidget extends StatelessWidget {
  const NotificationActionButtonWidget({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.onTap,
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Text(
            label,
            style: context.titleMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
