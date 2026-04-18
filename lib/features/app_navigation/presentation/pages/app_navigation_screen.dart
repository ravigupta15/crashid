import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/app_navigation/presentation/pages/drawer_screen.dart';
import 'package:crashid/features/home/presentation/pages/home_screen.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Main shell: [HomeScreen] plus custom bottom bar (no app bar).
class AppNavigationScreen extends StatefulWidget {
 
 static void open(BuildContext context) {
    context.push(AppRoutesPath.emergencyScreen);
  }

  const AppNavigationScreen({super.key});

  @override
  State<AppNavigationScreen> createState() => _AppNavigationScreenState();
}

class _AppNavigationScreenState extends State<AppNavigationScreen> {
  int _selectedBarIndex = 0;


  int get _stackIndex {
    switch (_selectedBarIndex) {
      case 0:
        return 0;
      case 1:
        return 1;
      case 3:
        return 2;
      case 4:
        return 3;
      default:
        return 0;
    }
  }

  void _onBarTap(int barIndex) {
    setState(() => _selectedBarIndex = barIndex);
  }

  void _onCenterFabTap() {
    context.push(AppRoutesPath.addAccidentScreen);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        leadingWidget: InkWell(
          onTap: () =>_scaffoldKey.currentState?.openDrawer(),
          child: Image.asset(AppAssetPaths.drawerIcon)),
        titleWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Hanover',
                    style: context.titleMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkGrayColor,
                    ),
                  ),
                ],
              ),
        actions: [
           Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      drawer: DrawerScreen(),
      body: _screenContent(),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

// -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

Widget _screenContent() {
  return HomeScreen();
   // body: IndexedStack(
      //   index: _stackIndex,
      //   children: const [
      //     HomeScreen(),
      //     _UserTabBody(),
      //     _CaseFileTabBody(),
      //     _SosTabBody(),
      //   ],
      // ),
     
}

  Widget _buildBottomBar(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 28),
          padding: EdgeInsets.only(top: 14, bottom: 10 + bottomInset),
          decoration:  BoxDecoration(
            color: AppColors.iceColor,
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000).withValues(alpha: .01),
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _BarIconButton(
                asset: AppAssetPaths.homeIcon,
                selected: _selectedBarIndex == 0,
                onTap: () => _onBarTap(0),
              ),
              _BarIconButton(
                asset: AppAssetPaths.userIcon,
                selected: _selectedBarIndex == 1,
                onTap: () => _onBarTap(1),
              ),
              const SizedBox(width: 56),
              _BarIconButton(
                asset: AppAssetPaths.caseFileIcon,
                selected: _selectedBarIndex == 3,
                onTap: () => _onBarTap(3),
              ),
              _BarIconButton(
                asset: AppAssetPaths.graySosIcon,
                selected: _selectedBarIndex == 4,
                onTap: () => _onBarTap(4),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: _CenterAddFab(onTap: _onCenterFabTap),
        ),
      ],
    );
  }
}

class _CenterAddFab extends StatelessWidget {
  const _CenterAddFab({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryColor,
      shape: const CircleBorder(),
      elevation: 6,
      shadowColor: AppColors.blackColor.withValues(alpha: 0.25),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Ink(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
            border: Border.all(color: AppColors.whiteColor, width: 4),
          ),
          child: const Icon(
            Icons.add,
            color: AppColors.whiteColor,
            size: 32,
          ),
        ),
      ),
    );
  }
}

class _BarIconButton extends StatelessWidget {
  const _BarIconButton({
    required this.asset,
    required this.selected,
    required this.onTap,
  });

  final String asset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Widget img = Image.asset(
      asset,
      height: 20,
      fit: BoxFit.contain,
      // color: selected ? AppColors.blackColor : inactiveTint,
    );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: img,
      ),
    );
  }
}
