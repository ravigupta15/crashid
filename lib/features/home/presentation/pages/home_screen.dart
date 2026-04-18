import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/home/presentation/widgets/home_action_widget.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.homeScreen);
  }

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _screenContent());
  }

  
// -----------------------------------------------------------------------------
// Widget Methods
// -----------------------------------------------------------------------------

Widget _screenContent() {
  return SingleChildScrollView(
    padding: EdgeInsets.only(top: 30),
    child: Column(
      children: [
        _heroCarSection(),
        const SizedBox(height: 28),
         _actionGridWidget(),
      ],
    ),
  );
}

Widget _heroCarSection() {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Image.asset(AppAssetPaths.logoCarImg)
    );
}

Widget _actionGridWidget() {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: HomeActionWidget(
                  iconAsset: AppAssetPaths.crashedCarIcon,
                  label: 'ADD ACCIDENT',
                  onTap: () => context.push(AppRoutesPath.addAccidentScreen),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: HomeActionWidget(
                  iconAsset: AppAssetPaths.myCarIcon,
                  label: 'MY CAR',
                  onTap: () => context.push(AppRoutesPath.myCarsScreen),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: HomeActionWidget(
                  iconAsset: AppAssetPaths.myInsuranceIcon,
                  label: 'MY INSURANCE',
                  onTap: () => context.push(AppRoutesPath.myInsuranceScreen),
                ),
              ),
              const SizedBox(width: 16),
                  Expanded(
                child: HomeActionWidget(
                  iconAsset: AppAssetPaths.sosIcon,
                  label: '',
                  onTap: () => context.push(AppRoutesPath.emergencyScreen),
                ),
              ),        ],
          ),
        ],
      ),
    );
}
}
