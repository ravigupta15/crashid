import 'dart:async';

import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/emergency/add_emergency/model/add_emergency_send_model.dart';
import 'package:crashid/features/emergency/add_emergency/model/search_user_response_model.dart';
import 'package:crashid/features/emergency/add_emergency/provider/add_emergency_notifier.dart';
import 'package:crashid/features/emergency/add_emergency/provider/add_emergency_state.dart';
import 'package:crashid/features/emergency/emergency/presentation/widgets/trusted_friend_card_widget.dart';
import 'package:crashid/features/widgets/app_textfield/app_searchbar_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:crashid/utils/no_data_found/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddEmergencyScreen extends ConsumerStatefulWidget {

  static Future<void> open(BuildContext context) {
   return context.push(AppRoutesPath.addEmergencyScreen,);
  }

  const AddEmergencyScreen({super.key});

  @override
  ConsumerState<AddEmergencyScreen> createState() => _AddEmergencyScreenState();
}

class _AddEmergencyScreenState extends ConsumerState<AddEmergencyScreen> {

  final searchController = TextEditingController();
  Timer? _debounce;
  AddEmergencySendModel? sendModel;
  
final emergencyNotifier =
    AsyncNotifierProvider<AddEmergencyNotifier, AddEmergencyState>(AddEmergencyNotifier.new);

bool isInitial = true;

    @override
  void initState() {
    sendModel = AddEmergencySendModel();
    super.initState();
   }

  void _callSearchApi(String? search) async{
     await ref.read(emergencyNotifier.notifier).searchApi(search: search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Emergency",
      ),
      body: _screenContent(),
    );
  }

   // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

Widget _screenContent() {
  final refState = ref.watch(emergencyNotifier);
  var model = refState.value?.searchUserResponseModel?.data;
  return ColoredBox(
      color: AppColors.screenBackground,
      child: Padding( padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
    child: Column(
      children: [
        AppSearchWidget(
          hintText: "alex@example.com",
          searchClackedCallBack: _onSearchbar, controller: searchController),
        Expanded(
          child: isInitial ? EmptyWidget() :
            ((model ?? []).isNotEmpty) ?
      ListView.separated(
          separatorBuilder: (cx, sb) => const SizedBox(height: 20,),
          itemCount: model?.length ?? 0,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 30, bottom: 30),
          itemBuilder: (context, index) {
            var items = model?[index];
            return TrustedFriendCardWidget(
              name: items?.displayName ?? '', 
            email: items?.email ?? '',
             plateNumber: items?.plateNumber ?? '',
              badgeLabel: '',
               initial: firstLetter(items?.displayName ?? ''),
              isStatus: false,
              img: items?.profileImageUrl,
              onDetails: () => _openDialogBox(items),
              );
        }) : NoDataFound()  
        ) 
      ],
    ),
      )
  );
  
  }

 
  void _onSearchbar(String? val) {
    isInitial = false;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
        _callSearchApi(val);
    });
  }

  String firstLetter(String item) {
    return item.isEmpty ? '' : item.substring(0)[0];
  }

  void _openDialogBox(UserModel? model) {
    AppDialogBox().openBox(
      maxWidthMinWidth: MediaQuery.of(context).size.width - 100,
      title: "Are you sure",
      subTitle: "Are you sure, you want to add?",
      yesTap: () => _addEmergencyApi(model)
    );
  }
   void _addEmergencyApi(UserModel? model) async{
    sendModel?.plateNumber = model?.plateNumber;
    sendModel?.userId = (model?.userId ?? '').toString();
    Navigator.pop(context);
     ref.read(emergencyNotifier.notifier).addEmergency(sendModel: sendModel);
  }
}