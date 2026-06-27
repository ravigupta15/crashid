import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/case_history/case_details/presentation/pages/case_details_screen.dart';
import 'package:crashid/features/case_history/case_history/presentation/widgets/case_detail_card_widget.dart';
import 'package:crashid/features/case_history/case_history/presentation/widgets/case_history_section_header.dart';
import 'package:crashid/features/case_history/case_history/presentation/widgets/case_history_tab_toggle.dart';
import 'package:crashid/features/case_history/case_history/provider/case_history_notifier.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:crashid/utils/linkers/launch_url.dart';
import 'package:crashid/utils/no_data_found/no_data_found.dart';
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



    @override
  void initState() {
    Future.microtask(() {
      _caseHistoryApi("current");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackgroundCool,
      appBar:(widget.isAppBarHide ?? false)? null : CustomAppBar(
        title: AppLocalizations.of(context)!.caseHistoryTitle,
       
      ),
      body:_screenContent(),
    );
  }

  Widget _screenContent() {
     final isCurrent = _tabIndex == 0;
     final refState = ref.watch(caseHistoryNotifierProvider);
     var caseModel = refState.value!.caseHistoryResponseModel?.data;

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
            title: isCurrent ? AppLocalizations.of(context)!.caseHistoryCurrentCases : AppLocalizations.of(context)!.caseHistoryPastCases,
            badgeLabel: isCurrent ? '${caseModel?.length ?? 0} ${AppLocalizations.of(context)!.active}' : "${caseModel?.length ?? 0} ${AppLocalizations.of(context)!.closed}",
          ),
          Expanded(
            child: (caseModel ?? []).isEmpty ?
            NoDataFound() :
             ListView.separated(
              separatorBuilder: (context, sb) {
                return const SizedBox(height: 30,);
              },
              itemCount: caseModel?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var model = caseModel?[index];
                return Column(
                  children: [
                    
            CaseDetailCardWidget(
                   accidentMetaLine: '${AppLocalizations.of(context)!.accidentDate}: ${AppDateFormat.formatMonthDateYear((model?.accidentDate ?? ''))} ${(model?.accidentTime ?? '').isNotEmpty ? "• ${model?.accidentTime ?? ''}" : ""}',
              caseIdLine: model?.caseNumber ?? '',
              address: model?.address ?? '',
              thumbnailAssets: model?.previewImages ?? [],
              overflowCount: 2,
              statusLabel: isCurrent ? model?.status : AppLocalizations.of(context)!.caseHistoryClosureDateLabel,
              clouserDate: isCurrent ? null : AppDateFormat.formatMonthDateYear((model?.closedAt ?? '')),
              onViewSummary: () => _openCaseDetailsScreen((model?.id ?? '').toString()),
            ),
            const SizedBox(height: 20,),
            AppElevatedButton.withTitleAndIcon(
              width: double.infinity,
              icon: Image.asset(AppAssetPaths.pdfIcon),
             title: AppLocalizations.of(context)!.caseHistoryDownloadPdf, onPressed: (){
              LaunchURLUtils().launchStringURL( model?.pdfUrl ?? '');
             },),
              ],
                );
            }),
          ), 
         ],
      ),
    );
  }

  void _onChanged(int? val) async{
    if (val != _tabIndex) {
      _caseHistoryApi(val == 1 ? "past" : "current");
    }
    setState(() {
      _tabIndex = val ?? 0;
    });
  }

void _openCaseDetailsScreen(String? id) {
    CaseDetailsScreen.open(context, id: id).then((val) {
        _caseHistoryApi(_tabIndex == 0 ? "current" : "past");
    });
}

void _caseHistoryApi(String? currentTab) {
  ref.read(caseHistoryNotifierProvider.notifier).caseHistory(context,currentTab: currentTab);
}
}
