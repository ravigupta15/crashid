import 'package:flutter/material.dart';

class DrawerMenuConfig {
  const DrawerMenuConfig({
    required this.icon,
    this.routePath,
  });

  final IconData icon;
  final String? routePath;
}

class DrawerMenuHelper {
  DrawerMenuHelper._();

  static const List<DrawerMenuConfig> menuConfigs = [
    DrawerMenuConfig(
      icon: Icons.person,
    ),
    DrawerMenuConfig(
      icon: Icons.description_outlined,
    ),
    DrawerMenuConfig(
      icon: Icons.translate_rounded,
    ),
    DrawerMenuConfig(
      icon: Icons.add_alert_outlined,
    ),
    DrawerMenuConfig(icon: Icons.receipt_long_rounded),
    DrawerMenuConfig(icon: Icons.article_outlined),
    DrawerMenuConfig(icon: Icons.privacy_tip_outlined),
    DrawerMenuConfig(icon: Icons.shield_outlined),
    DrawerMenuConfig(icon: Icons.logout_rounded),
  ];
}
