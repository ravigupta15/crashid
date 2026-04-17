import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final Color activeColor;
  final Color borderColor;
  final double size;
  final TextStyle? labelStyle;
  final double spacing;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeColor = Colors.black,
    this.borderColor = const Color(0xFF2A2A2A),
    this.size = 18.0,
    this.labelStyle,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: value ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: value ? activeColor : borderColor.withValues(alpha: .3),
              ),
            ),
            child: value
                ?  Icon(Icons.check, size: 16, color: AppColors.whiteColor,)
                : null,
          ),
          if (label != null) ...[
            SizedBox(width: spacing),
            Flexible(
              child: Text(
                label!,
                style:
                    labelStyle ??
                    context.titleMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
