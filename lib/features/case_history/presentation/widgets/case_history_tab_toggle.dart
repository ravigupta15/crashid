import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

/// Capsule toggle between "Current Cases" and "Past Cases".
class CaseHistoryTabToggle extends StatelessWidget {
  const CaseHistoryTabToggle({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  static const _labels = ['Current Cases', 'Past Cases'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(54),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Row(
        children: List.generate(_labels.length, (i) {
          final selected = selectedIndex == i;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selected ? AppColors.primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(54),
                ),
                alignment: Alignment.center,
                child: Text(
                  _labels[i],
                  textAlign: TextAlign.center,
                  style: context.titleSmall.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: selected ? AppColors.accentColor : AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
