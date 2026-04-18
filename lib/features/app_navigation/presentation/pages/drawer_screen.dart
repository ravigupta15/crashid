import 'package:crashid/features/app_navigation/helpers/drawer_menu_helper.dart';
import 'package:crashid/features/app_navigation/presentation/widgets/drawer_profile_banner_widget.dart';
import 'package:crashid/features/app_navigation/presentation/widgets/drawer_vertical_menu_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  int _selectedIndex = -1;

  List<DrawerMenuItemData> get _menuItems {
    return List.generate(DrawerMenuHelper.menuConfigs.length, (index) {
      final config = DrawerMenuHelper.menuConfigs[index];
      return DrawerMenuItemData(
        title: config.title,
        icon: config.icon,
        isActive: _selectedIndex == index,
      );
    });
  }

  void _handleDrawerItemTap(int index) {
    final config = DrawerMenuHelper.menuConfigs[index];
    setState(() => _selectedIndex = index);

    if (config.routePath != null) {
      context.push(config.routePath!);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications, color: AppColors.primaryColor),
          ),
        ],
      ),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24, top: 20),
      child: Column(
        children: [
          const DrawerProfileBannerWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 22, 16, 0),
            child: DrawerVerticalMenuWidget(
              items: _menuItems,
              onTap: _handleDrawerItemTap,
            ),
          ),
        ],
      ),
    );
  }
}
