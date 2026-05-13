import 'dart:async';

import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/add_accident/provider/add_accident_notifier.dart';
import 'package:crashid/features/add_accident/provider/add_accident_state.dart';
import 'package:crashid/features/emergency/add_emergency/model/search_user_response_model.dart';
import 'package:crashid/features/emergency/emergency/presentation/widgets/trusted_friend_card_widget.dart';
import 'package:crashid/features/widgets/app_textfield/app_searchbar_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const kUserModel = "/kUserModel";

  final UserModel? model;
  const SearchScreen({super.key, this.model});


  static Future<UserModel?> open(BuildContext context, UserModel? model) {
   return context.push(AppRoutesPath.searchScreen,extra: {
    kUserModel: model
   });
  }
  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {

  
final addAccidentNotifierProvider =
    AsyncNotifierProvider<AddAccidentNotifier, AddAccidentState>(AddAccidentNotifier.new);


final searchController = TextEditingController();


bool isInitial = true;
Timer? _debounce;

@override
  void initState() {
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
       return Navigator.pop(context, widget.model);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          onPressed: () => Navigator.pop(context, widget.model),
        ),
        body: _screenContent(),
      ),
    );
  }

  Widget _screenContent() {
    final refState = ref.watch(addAccidentNotifierProvider);
    var model = refState.value?.searchUserResponseModel?.data;
    return ColoredBox(
        color: AppColors.screenBackground,
      child: Padding(  
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
        child: Column(
          children: [
            AppSearchWidget(searchClackedCallBack: _onSearchbar,
             controller: searchController),
             const SizedBox(height: 10,),
             Expanded(
              child: ListView.separated(
                separatorBuilder: (context, sb) {
                  return const SizedBox(height: 15,);
                },
              itemCount: model?.length ?? 0,
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              itemBuilder: (context, index){
                var items = model?[index];
                return TrustedFriendCardWidget(
                name: items?.displayName ?? '', 
              email: items?.email ?? '',
               plateNumber: items?.plateNumber ?? '',
                badgeLabel: '',
                 initial: firstLetter(items?.displayName ?? ''),
                isStatus: false,
                img: items?.profileImageUrl ?? '',
                onDetails: () => Navigator.pop(context, items),
                ); 
               }))
          ],
        ),
      ),
    );
  }


  String firstLetter(String item) {
    return item.isEmpty ? '' : item.substring(0)[0];
  }


  void _onSearchbar(String? val) {
    isInitial = false;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
        _callSearchApi(val);
    });
  }
  void _callSearchApi(String? val) {
    ref.read(addAccidentNotifierProvider.notifier).searchPlateNumber(val);
  }
}