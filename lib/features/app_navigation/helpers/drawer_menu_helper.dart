import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:flutter/material.dart';

class DrawerMenuConfig {
  const DrawerMenuConfig({
    required this.title,
    required this.icon,
    this.routePath,
  });

  final String title;
  final IconData icon;
  final String? routePath;
}

class DrawerMenuHelper {
  DrawerMenuHelper._();

  static const List<DrawerMenuConfig> menuConfigs = [
    DrawerMenuConfig(
      title: 'My Profile',
      icon: Icons.person,
      routePath: AppRoutesPath.profileScreen,
    ),
    DrawerMenuConfig(
      title: 'Case History',
      icon: Icons.description_outlined,
      routePath: AppRoutesPath.myCarsScreen,
    ),
    DrawerMenuConfig(
      title: 'Change Language',
      icon: Icons.translate_rounded,
    ),
    DrawerMenuConfig(
      title: 'Emergency Settings',
      icon: Icons.add_alert_outlined,
    ),
    DrawerMenuConfig(title: 'Imprint', icon: Icons.receipt_long_rounded),
    DrawerMenuConfig(title: 'AGB', icon: Icons.article_outlined),
    DrawerMenuConfig(title: 'Data Security', icon: Icons.privacy_tip_outlined),
    DrawerMenuConfig(title: 'Privacy Policy', icon: Icons.shield_outlined),
    DrawerMenuConfig(title: 'Log Out', icon: Icons.logout_rounded),
  ];
}
