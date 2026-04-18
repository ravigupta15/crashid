import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class DrawerMenuItemData {
  final String title;
  final IconData icon;
  final bool isActive;
  final bool isDisabled;

  const DrawerMenuItemData({
    required this.title,
    required this.icon,
    this.isActive = false,
    this.isDisabled = false,
  });
}

class DrawerVerticalMenuWidget extends StatelessWidget {
  final List<DrawerMenuItemData> items;
  final ValueChanged<int>? onTap;
  const DrawerVerticalMenuWidget({super.key, required this.items, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 70,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: AppColors.iceColor,
            borderRadius: BorderRadius.circular(142),
          ),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++)
                _RailIconTile(data: items[i], onTap: () => onTap?.call(i)),
            ],
          ),
        ),
        const SizedBox(width: 22),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < items.length; i++)
                  InkWell(
                    onTap: () => onTap?.call(i),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        items[i].title,
                        style: context.titleMedium.copyWith(
                          fontSize: 15,
                          fontWeight: items[i].isActive
                              ? FontWeight.w800
                              : FontWeight.w500,
                          color: AppColors.darkGrayColor
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RailIconTile extends StatelessWidget {
  final DrawerMenuItemData data;
  final VoidCallback onTap;

  const _RailIconTile({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bool isActive = data.isActive;
    final Color iconColor = data.isDisabled
        ? AppColors.blackColor.withValues(alpha: 0.22)
        : AppColors.blackColor.withValues(alpha: isActive ? 0.95 : 0.35);

    return Material(
      color: isActive ? AppColors.accentColor : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 88,
          height: 51,
          child: Icon(data.icon, color: iconColor, size: 28),
        ),
      ),
    );
  }
}
