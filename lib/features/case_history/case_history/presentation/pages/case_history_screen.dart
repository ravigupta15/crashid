import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/add_car/provider/add_car_notifier.dart';
import 'package:crashid/features/case_history/case_details/presentation/pages/case_details_screen.dart';
import 'package:crashid/features/case_history/case_history/presentation/widgets/case_detail_card_widget.dart';
import 'package:crashid/features/case_history/case_history/presentation/widgets/case_history_section_header.dart';
import 'package:crashid/features/case_history/case_history/presentation/widgets/case_history_tab_toggle.dart';
import 'package:crashid/features/case_history/case_history/provider/case_history_notifier.dart';
import 'package:crashid/features/case_history/case_history/provider/case_history_state.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CaseHistoryScreen extends ConsumerStatefulWidget {
   static const kIsAppbarHide = "/kIsAppbarHide";

  final bool? isAppBarHide;

 
    static void open(BuildContext context, {
    bool? isAppBarHide
  }) {
    context.push(AppRoutesPath.caseHistoryScreen, extra: {
      kIsAppbarHide: isAppBarHide
    });
  }

  const CaseHistoryScreen({super.key, this.isAppBarHide});

  @override
  ConsumerState<CaseHistoryScreen> createState() => _CaseHistoryScreenState();
}

class _CaseHistoryScreenState extends ConsumerState<CaseHistoryScreen> {
  int _tabIndex = 0;



final caseHistoryotifierProvider =
    AsyncNotifierProvider<CaseHistoryNotifier, CaseHistoryState>(CaseHistoryNotifier.new);

    @override
  void initState() {
    _caseHistoryApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundCool,
      appBar:(widget.isAppBarHide ?? false)? null : CustomAppBar(
        title: "Case History",
       
      ),
      body:_screenContent(),
    );
  }

  Widget _screenContent() {
     final isCurrent = _tabIndex == 0;
   
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CaseHistoryTabToggle(
            selectedIndex: _tabIndex,
            onChanged: _onChanged,
          ),
          CaseHistorySectionHeader(
            title: isCurrent ? 'Current Cases' : 'Past Cases',
            badgeLabel: isCurrent ? '1 Active' : "1 Closed",
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
            CaseDetailCardWidget(
              accidentMetaLine: 'Accident Date: Aug 29, 2023 • 18:45',
              caseIdLine: 'KDL-4432',
              address: 'Broad St & Market St, Philadelphia, PA 19107, USA',
              thumbnailAssets: const [
                "assets/images/img1.png",
                "assets/images/img2.png",
                "assets/images/img2.png",
                "assets/images/img2.png",
              ],
              overflowCount: 2,
              statusLabel: isCurrent ? 'In Review' : "CLOSURE DATE",
              clouserDate: isCurrent ? null : "Sep 28, 2023",
              onViewSummary: () => _openCaseDetailsScreen('id'),
            ),
            const SizedBox(height: 30,),
            AppElevatedButton.withTitleAndIcon(
              width: double.infinity,
              icon: Image.asset(AppAssetPaths.pdfIcon),
             title: 'Download Case PDF', onPressed: (){},),
              ],
                );
            }),
          ), 
         ],
      ),
    );
  }

  void _onChanged(int? val) async{
    setState(() {
      _tabIndex = val ?? 0;
    });
  }

void _openCaseDetailsScreen(String? id) {
    CaseDetailsScreen.open(context, id: id);
}

void _caseHistoryApi() {
  ref.read(caseHistoryotifierProvider.notifier).caseHistory(context,currentTab: _tabIndex == 1 ? "past" : "current");
}
}
