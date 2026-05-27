import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:flutter/material.dart';

class NotificationCaseDetailRowWidget extends StatelessWidget {
  const NotificationCaseDetailRowWidget({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: context.bodyMedium.copyWith(
              fontSize: 14,
              color: Color(0xff434654).withValues(alpha: .7),
            ),
          ),
        ),
        // const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            maxLines: 2,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: context.bodyMedium.copyWith(
              fontSize: 12,
              color: Color(0xff121C28),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
