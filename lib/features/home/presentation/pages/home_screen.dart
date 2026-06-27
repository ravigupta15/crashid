import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/features/add_accident/presentation/pages/add_accident_screen.dart';
import 'package:crashid/features/add_car/presentation/pages/add_car_screen.dart';
import 'package:crashid/features/app_navigation/presentation/widgets/add_car_diloag_content.dart';
import 'package:crashid/features/emergency/emergency/model/sos_send_model.dart';
import 'package:crashid/features/emergency/emergency/presentation/pages/emergency_screen.dart';
import 'package:crashid/features/emergency/emergency/provider/emergency_notifier.dart';
import 'package:crashid/features/emergency/emergency/provider/emergency_state.dart';
import 'package:crashid/features/home/presentation/widgets/add_emergency_contact_widget.dart';
import 'package:crashid/core/service/location_service.dart';
import 'package:crashid/features/home/presentation/widgets/home_action_widget.dart';
import 'package:crashid/features/home/presentation/widgets/sos_widget.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/features/my_cars/presentation/pages/my_cars_screen.dart';
import 'package:crashid/features/my_cars/provider/my_car_notifier.dart';
import 'package:crashid/features/my_cars/provider/my_car_state.dart';
import 'package:crashid/features/my_insurance/presentation/pages/my_insurance_screen.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.homeScreen);
  }

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final emergencyNotifier =
      AsyncNotifierProvider<EmergencyNotifier, EmergencyState>(
        EmergencyNotifier.new,
      );

  bool isData = false;

  SosSendModel? sendModel;
  final myCarNotifierProvider =
      AsyncNotifierProvider<MyCarNotifier, MyCarState>(MyCarNotifier.new);

  @override
  void initState() {
    sendModel = SosSendModel();
    _callInitFunction();
    super.initState();
  }

  void _callInitFunction() async {
    _emergencyApi();

    final location = await LocationService.getCurrentLocationWithAddress();

    sendModel ??= SosSendModel();
    sendModel!
      ..lat = location.latitude.toString()
      ..lng = location.longitude.toString()
      ..address = location.fullAddress;
  }

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
      child: Image.asset(AppAssetPaths.logoCarImg),
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
                  label: AppLocalizations.of(context)!.homeAddAccident,
                  onTap: () {
                    if (GetIt.I.get<UserManager>().carAdded) {
                      _openAddAccidentScreen();
                    } else {
                      _openAddCarDialogBox();
                    }
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: HomeActionWidget(
                  iconAsset: AppAssetPaths.myCarIcon,
                  label: AppLocalizations.of(context)!.homeMyCar,
                  onTap: _openMycarScreen,
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
                  label: AppLocalizations.of(context)!.homeMyInsurance,
                  onTap: _openInsuranceScreen,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: HomeActionWidget(
                  iconAsset: AppAssetPaths.sosIcon,
                  label: '',
                  onTap: isData
                      ? _openSosDialogBox
                      : _openAddEmergencyDialogBox,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  void _emergencyApi() async {
    await ref.read(emergencyNotifier.notifier).emergencyApi().then((val) {
      isData = val;
      setState(() {});
    });
  }

  void _openAddAccidentScreen() {
    AddAccidentScreen.open(context);
  }

  void _openMycarScreen() {
    MyCarsScreen.open(context).then((val) {
      print((GetIt.I.get<UserManager>().carAdded));
    });
  }

  void _openInsuranceScreen() {
    MyInsuranceScreen.open(context);
  }

  void _openEmergencyScreen() {
    EmergencyScreen.open(context);
  }

  void _openSosDialogBox() {
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.of(context).size.width * .8,
      screenContent: SosWidget(onClickSend: (val) => _onClickSend(val)),
    );
  }

  void _openAddEmergencyDialogBox() {
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.of(context).size.width * .8,
      screenContent: AddEmergencyContactWidget(
        callback: () {
          Navigator.pop(context);
          _openEmergencyScreen();
        },
      ),
    );
  }

  void _onClickSend(String? msg) {
    sendModel?.msg = msg;
    Navigator.pop(context);
    ref.read(emergencyNotifier.notifier).sosEmergencyApi(sendModel);
  }

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
