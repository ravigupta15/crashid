import 'package:crashid/features/app_navigation/helpers/drawer_menu_helper.dart';
import 'package:crashid/features/app_navigation/presentation/widgets/drawer_profile_banner_widget.dart';
import 'package:crashid/features/app_navigation/presentation/widgets/drawer_vertical_menu_widget.dart';
import 'package:crashid/features/case_history/presentation/pages/case_history_screen.dart';
import 'package:crashid/features/emergency/presentation/pages/emergency_screen.dart';
import 'package:crashid/features/language/presentation/language_screen.dart';
import 'package:crashid/features/profile/presentation/pages/profile_screen.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/logout/app_logout.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
       
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

    // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

  void _handleDrawerItemTap(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
    case 0:
      _openMyProfileScreen();
      break;
    case 1:
      _openCaseHistoryScreen();
      break;
    case 2:
      _openLanguageScreen();
      break;
    case 3:
      _openEmergencyScreen();
      break;
    case 8:
    AppLogoutHelper.logout();
      break;  
    default:
      debugPrint("No screen defined for index $index");
  }
  
  }
  
  void _openMyProfileScreen() {
    ProfileScreen.open(context);
  }

  void _openCaseHistoryScreen() {
    CaseHistoryScreen.open(context);
  }

  void _openLanguageScreen() {
    LanguageScreen.open(context, isChangeLanguageRoute: true);
  }

  void _openEmergencyScreen() {
    EmergencyScreen.open(context);
  }
}
