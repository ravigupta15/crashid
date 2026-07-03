import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/lookup/language_provider.dart';
import 'package:crashid/core/service/location_service.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/features/app_navigation/presentation/pages/drawer_screen.dart';
import 'package:crashid/features/app_navigation/presentation/widgets/add_car_diloag_content.dart';
import 'package:crashid/features/case_history/case_history/presentation/pages/case_history_screen.dart';
import 'package:crashid/features/case_history/case_history/provider/case_history_notifier.dart';
import 'package:crashid/features/emergency/emergency/presentation/pages/emergency_screen.dart';
import 'package:crashid/features/emergency/emergency/provider/emergency_notifier.dart';
import 'package:crashid/features/home/presentation/pages/home_screen.dart';
import 'package:crashid/features/add_car/presentation/pages/add_car_screen.dart';
import 'package:crashid/features/my_cars/provider/my_car_notifier.dart';
import 'package:crashid/features/my_cars/provider/my_car_state.dart';
import 'package:crashid/features/notification/provider/notification_notifier.dart';
import 'package:crashid/features/profile/presentation/pages/profile_screen.dart';
import 'package:crashid/features/profile/provider/profile_notifier.dart';
import 'package:crashid/features/profile/provider/profile_state.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:crashid/utils/extensions/extension_navigator.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AppNavigationScreen extends ConsumerStatefulWidget {
  static const kInitialIndex = '/kInitialIndex';

  final int? initialIndex;
  static void open(BuildContext context, {int? initialIndex}) {
    context.pushNamedAndRemoveUntil(
      AppRoutesPath.appNavigationScreen,
      extra: {kInitialIndex: initialIndex},
    );
  }

  const AppNavigationScreen({super.key, this.initialIndex});

  @override
  ConsumerState<AppNavigationScreen> createState() =>
      _AppNavigationScreenState();
}

class _AppNavigationScreenState extends ConsumerState<AppNavigationScreen> {
  int _selectedBarIndex = 0;

  String? city;

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

    Future.microtask(() {
      // Trigger profile API when profile tab (1) is tapped
      if (barIndex == 1) {
        ref.read(profileNotifier.notifier).getProfile(context);
      }
      // Trigger case history API when case history tab (3) is tapped
      else if (barIndex == 3) {
        ref
            .read(caseHistoryNotifierProvider.notifier)
            .caseHistory(context, currentTab: 'current');
      }
      // Trigger emergency API when SOS tab (4) is tapped
      else if (barIndex == 4) {
        ref.read(emergencyNotifier.notifier).emergencyApi();
      }
    });
  }

  void _onCenterFabTap() {
    (GetIt.I.get<UserManager>().carAdded)
        ? context.push(AppRoutesPath.addAccidentScreen)
        : _openAddCarDialogBox();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final myCarNotifierProvider =
      AsyncNotifierProvider<MyCarNotifier, MyCarState>(MyCarNotifier.new);

  final profileNotifierProvider =
      AsyncNotifierProvider<ProfileNotifier, ProfileState>(ProfileNotifier.new);    

  @override
  void initState() {
    _selectedBarIndex = widget.initialIndex ?? 0;
    callInitFunction();
    super.initState();
  }

  void callInitFunction() async {
    Future.microtask(() async {
      final data = await LocationService.getCurrentLocationWithAddress();
      city = data.city;
      setState(() {});
      print("Current city: $city");
      // Call the myCar API and check if the user has any cars added. If not, open the add car dialog box.
      await ref.read(myCarNotifierProvider.notifier).myCar().then((val) {
        if (val == false) {
          _openAddCarDialogBox();
        }
      });

      // call fcm token API to register the device for push notifications
      await ref.read(notificationProvider.notifier).fcmToken();

      await ref.read(profileNotifierProvider.notifier).updateProfileLanguage();
    });
  }

  @override
  void didUpdateWidget(covariant AppNavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    final targetIndex = widget.initialIndex;

    // Compare the incoming request directly against the current runtime state index
    if (targetIndex != null && targetIndex != _selectedBarIndex) {
      setState(() {
        _selectedBarIndex = targetIndex;
      });
      // Fire the API calls linked to that tab
      Future.microtask(() => _onBarTap(_selectedBarIndex));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        leadingWidget: InkWell(
          onTap: () => _scaffoldKey.currentState?.openDrawer(),
          child: Image.asset(AppAssetPaths.drawerIcon),
        ),
        titleWidget: city.isNotNullOrNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 20,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    city ?? '',
                    style: context.titleMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkGrayColor,
                    ),
                  ),
                ],
              )
            : EmptyWidget(),
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
    return IndexedStack(
      index: _stackIndex,
      children: [
        HomeScreen(),
        ProfileScreen(isAppBarHide: true),
        CaseHistoryScreen(isAppBarHide: true),
        EmergencyScreen(isAppBarHide: true),
      ],
    );
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
          decoration: BoxDecoration(
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
                asset: _selectedBarIndex == 0
                    ? AppAssetPaths.homeIcon
                    : AppAssetPaths.homeGrayIcon,
                selected: _selectedBarIndex == 0,
                onTap: () => _onBarTap(0),
              ),
              _BarIconButton(
                asset: _selectedBarIndex == 1
                    ? AppAssetPaths.userBlackIcon
                    : AppAssetPaths.userIcon,
                selected: _selectedBarIndex == 1,
                onTap: () => _onBarTap(1),
              ),
              const SizedBox(width: 56),
              _BarIconButton(
                asset: _selectedBarIndex == 3
                    ? AppAssetPaths.caseFileBlackIcon
                    : AppAssetPaths.caseFileIcon,
                selected: _selectedBarIndex == 3,
                onTap: () => _onBarTap(3),
              ),
              _BarIconButton(
                asset: _selectedBarIndex == 4
                    ? AppAssetPaths.sosBlackIcon
                    : AppAssetPaths.graySosIcon,
                selected: _selectedBarIndex == 4,
                onTap: () => _onBarTap(4),
              ),
            ],
          ),
        ),
        Positioned(top: 0, child: _CenterAddFab(onTap: _onCenterFabTap)),
      ],
    );
  }

  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

  void _openAddCarDialogBox() {
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.of(context).size.width * .8,
      screenContent: AddCarDiloagContent(onClickAddCar: _openAddCarScreen),
    );
  }

  void _openAddCarScreen() {
    Navigator.pop(context);
    AddCarScreen.open(context).then((val) async {
      await ref.read(myCarNotifierProvider.notifier).myCar();
    });
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
          child: const Icon(Icons.add, color: AppColors.whiteColor, size: 32),
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
