import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:crashid/di/service_locator.dart';
import 'package:crashid/features/add_accident/model/add_accident_send_model.dart';
import 'package:crashid/features/add_accident/presentation/pages/add_accident_screen.dart';
import 'package:crashid/features/add_accident/presentation/pages/other_accident_screen.dart';
import 'package:crashid/features/add_accident/presentation/widgets/accident_details_widget.dart';
import 'package:crashid/features/case_history/case_details/model/case_details_response_model.dart';
import 'package:crashid/features/case_history/case_details/provider/case_details_notifier.dart';
import 'package:crashid/features/case_history/case_details/provider/case_details_state.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_video_player/app_video_player_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:crashid/utils/app_dialog_box/app_dialog_box.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:crashid/utils/empty/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CaseDetailsScreen extends ConsumerStatefulWidget {
  static const String kId = "kId";

  final String? id;
  static Future<void> open(BuildContext context, {String? id}) {
    return context.push(AppRoutesPath.caseDetailsScreen, extra: {kId: id});
  }

  const CaseDetailsScreen({super.key, this.id});

  @override
  ConsumerState<CaseDetailsScreen> createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends ConsumerState<CaseDetailsScreen> {
  final casedetailsNotifierProvider =
      AsyncNotifierProvider<CaseDetailsNotifier, CaseDetailsState>(
        CaseDetailsNotifier.new,
      );

  AddAccidentSendModel? sendModel;
  @override
  void initState() {
    super.initState();
    _caseDetailsApi();
    sendModel = AddAccidentSendModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.caseDetailsSummaryTitle),
      body: _screenContent(),
    );
  }
  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    final refState = ref.watch(casedetailsNotifierProvider);
    var caseDetails = refState.value?.caseDetailsResponseModel?.data;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
             '${AppLocalizations.of(context)!.caseId}: ${caseDetails?.caseNumber}',
            style: context.bodyMedium.copyWith(
              color: AppColors.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          ListView.separated(
            separatorBuilder: (context, sb) {
              return const SizedBox(height: 20);
            },
            padding: EdgeInsets.only(top: 20),
            itemCount: caseDetails?.participants?.length ?? 0,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var model = caseDetails?.participants?[index];
              return Column(
                children: [
                  _caseNameWidget(model?.username ?? ''),
                  const SizedBox(height: 39),
                  _plateNumberWidget(model?.plate ?? ''),
                  if ((model?.images ?? []).isNotEmpty)
                    _evidenceWidget(
                      model?.images?.map((e) => e.fileUrl ?? '').toList() ?? [],
                    ),
                  if ((model?.videos ?? []).isNotEmpty)
                    _evidenceVideoWidget(
                      model?.videos?.map((e) => e.fileUrl ?? '').toList() ?? [],
                    ),
                  const SizedBox(height: 25),
                  _caseDescriptionWidget(model?.description),
                  const SizedBox(height: 20),
                  AccidentDetailsWidget(
                    isAccidentTitle: false,
                    dateValue: AppDateFormat.formatMonthDateYear(
                      (model?.accidentDate ?? ''),
                    ),
                    timeValue: model?.accidentTime ?? '',
                    locationValue: model?.address ?? '',
                  ),
                  caseDetails?.participants != null &&
                          index != (caseDetails?.participants?.length ?? 0) - 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          child: Divider(
                            color: AppColors.blackColor.withValues(alpha: .2),
                          ),
                        )
                      : EmptyWidget(),
                ],
              );
            },
          ),

          const SizedBox(height: 30),
          _paymentStatusWidget(caseDetails),
          const SizedBox(height: 22),

          if ((caseDetails?.status ?? '').toString().toLowerCase() == 'draft')
            AppElevatedButton.withTitleAndIcon(
              width: double.infinity,
              icon: Image.asset(
                AppAssetPaths.retryPaymentIcon,
                width: 20,
                height: 20,
              ),
              title: AppLocalizations.of(context)!.caseDetailsRetryPayment,
              onPressed: () =>
                  _openOtherAccidentScreen(caseDetails?.id.toString()),
            ),

          // Check for participant B/C with pending submission status
          if (_shouldShowAcceptRejectButtons(caseDetails))
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: AppElevatedButton.withTitle(
                      title: AppLocalizations.of(context)!.accept,
                      textColor: AppColors.whiteColor,
                      isBoxShadow: false,
                      height: 48,
                      onPressed: () =>
                          _openAddAccidentScreen(caseDetails?.id.toString()),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppElevatedButton.withTitle(
                      title: AppLocalizations.of(context)!.reject,
                      color: AppColors.aliceBlueColor,
                      isBoxShadow: false,
                      height: 48,
                      textColor: AppColors.blackColor,
                      onPressed: () => _rejectParticipantRequest(
                        caseDetails?.id.toString(),
                        _userBAndUserC(caseDetails),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if (_shouldShowRejectedStatus(caseDetails))
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.redColor.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.caseDetailsRejectedMessage,
                    style: context.bodyMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.redColor,
                    ),
                  ),
                ),
              ),
            ),

          if ((caseDetails?.status ?? '').toString().toLowerCase() != 'draft' &&
              (caseDetails?.closeStatus?.showCloseButton ?? false) &&
              !_shouldShowAcceptRejectButtons(caseDetails) &&
              !_shouldShowRejectedStatus(caseDetails))
            AppElevatedButton.withTitleAndIcon(
              width: double.infinity,
              icon: Icon(Icons.check, color: AppColors.accentColor),
              title: AppLocalizations.of(context)!.caseDetailsCloseAccidentCase,
              onPressed: () => _cofirmationDialog(caseDetails?.id.toString()),
            ),
        ],
      ),
    );
  }

  Widget _caseNameWidget(String? name) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Row(
        children: [
          Image.asset(AppAssetPaths.circlePersonIcon, width: 24, height: 24),
          const Spacer(),
          Text(
            name ?? AppLocalizations.of(context)!.unknown,
            style: context.bodyMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _plateNumberWidget(String? plateNumber) {
    return Container(
      height: 55,
      padding: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.blackColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 20,
            color: AppColors.blackColor.withValues(alpha: .2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssetPaths.roundStrokeIcon),
                const SizedBox(height: 5),
                Text(
                  "D",
                  style: context.bodyMedium.copyWith(
                    fontSize: 10,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            plateNumber ?? '',
            style: context.titleMedium.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _evidenceWidget(List imagePaths) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.caseDetailsEvidenceImages,
            style: context.bodyMedium.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AppCachedNetworkImage(
                  imageUrl: imagePaths[index],
                  boxFit: BoxFit.cover,
                  canOpenImage: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _evidenceVideoWidget(List videos) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.caseDetailsEvidenceVideos,
            style: context.bodyMedium.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 10),
          AppVideoPlayerWidget(
            videoUrl: videos.isNotEmpty ? videos[0] : null,
            height: 220,
            showFullScreenButton: true,
          ),
        ],
      ),
    );
  }

  Widget _caseDescriptionWidget(String? description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xffEEF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.caseDetailsDescriptionTitle,
            style: context.bodyMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description ?? AppLocalizations.of(context)!.caseDetailsNoDescription,
            style: context.bodyMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xff434654),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentStatusWidget(CaseDetails? model) {
    String paymentStatus = model?.paymentStatus ?? '';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xff00544C).withValues(alpha: .1),
      ),
      padding: EdgeInsets.symmetric(vertical: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            paymentStatus == 'paid'
                ? AppAssetPaths.checkIcon
                : AppAssetPaths.statusPendingIcon,
          ),
          const SizedBox(width: 6),
          Text(
             "${AppLocalizations.of(context)!.caseDetailsPaymentStatus}: ${paymentStatus.toUpperCase()}",
            style: context.bodyMedium.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: paymentStatus == 'paid'
                  ? Color(0xff00544C)
                  : Color(0xffFF0000),
            ),
          ),
        ],
      ),
    );
  }

  void _cofirmationDialog(String? caseId) {
    AppDialogBox().openBox(
      title: AppLocalizations.of(context)!.caseDetailsCloseCaseTitle,
      maxWidthMinWidth: MediaQuery.of(context).size.width * .8,
      subTitle: AppLocalizations.of(context)!.caseDetailsCloseCaseConfirmation,
      yesTap: () {
        Navigator.of(context).pop();
        _caseClosedApi(caseId);
      },
    );
  }

  void _caseDetailsApi() {
    ref.read(casedetailsNotifierProvider.notifier).caseDetails(widget.id);
  }

  void _openOtherAccidentScreen(String? caseId) {
    OtherAccidentScreen.open(
      context,
      caseId: caseId,
      route: "case_details",
    ).then((val) {
      _caseDetailsApi();
    });
  }

  void _caseClosedApi(String? caseId) {
    ref.read(casedetailsNotifierProvider.notifier).caseClosed(caseId);
  }

  void _openAddAccidentScreen(String? caseId) {
    AddAccidentScreen.open(context, caseId: caseId, routeName: "accept").then((
      val,
    ) {
      _caseDetailsApi();
    });
  }

  void _userBRejectApi(String? caseId) {
    ref.read(casedetailsNotifierProvider.notifier).userBReject(caseId);
  }

  void _userWitnessRejectApi(String? caseId) {
    sendModel?.caseId = caseId;
    sendModel?.witnessAction = "rejected";
    ref
        .read(casedetailsNotifierProvider.notifier)
        .userWitnessReject(sendModel: sendModel);
  }

  bool _shouldShowAcceptRejectButtons(CaseDetails? caseDetails) {
    if (caseDetails?.participants == null) return false;

    String currentUserId = ServiceLocator.get<UserManager>().userId;

    String submissionStatus = (caseDetails?.requestStatus ?? '')
        .toString()
        .toLowerCase();

    for (var participant in caseDetails!.participants!) {
      // String submissionStatus = (participant.submissionStatus ?? '').toString().toLowerCase();
      String participantRole = (participant.role ?? '')
          .toString()
          .toUpperCase();

      // Check if participant role is B or C
      bool isParticipantBC =
          participantRole == 'USER_B' || participantRole == 'USER_C';

      // Check if userId matches and submission status is pending
      if (isParticipantBC &&
          participant.id.toString() == currentUserId &&
          submissionStatus == '') {
        return true;
      }
    }

    return false;
  }

  bool _shouldShowRejectedStatus(CaseDetails? caseDetails) {
    if (caseDetails?.participants == null) return false;

    String currentUserId = ServiceLocator.get<UserManager>().userId;

    String submissionStatus = (caseDetails?.requestStatus ?? '')
        .toString()
        .toLowerCase();

    for (var participant in caseDetails!.participants!) {
      String participantRole = (participant.role ?? '')
          .toString()
          .toUpperCase();

      // Check if participant role is B or C
      bool isParticipantBC =
          participantRole == 'USER_B' || participantRole == 'USER_C';

      // Check if userId matches and submission status is pending
      if (isParticipantBC &&
          participant.id.toString() == currentUserId &&
          submissionStatus == 'rejected') {
        return true;
      }
    }

    return false;
  }

  String _userBAndUserC(CaseDetails? caseDetails) {
    if (caseDetails?.participants == null) return '';

    String currentUserId = ServiceLocator.get<UserManager>().userId;

    for (var participant in caseDetails!.participants!) {
      String participantRole = (participant.role ?? '')
          .toString()
          .toUpperCase();

      bool isParticipantBC =
          participantRole == 'USER_B' || participantRole == 'USER_C';

      // Check if userId matches and submission status is pending
      if (isParticipantBC && participant.id.toString() == currentUserId) {
        return participantRole;
      }
    }

    return '';
  }

  void _rejectParticipantRequest(String? caseId, String? participantRole) {
    AppDialogBox().openBox(
      title: AppLocalizations.of(context)!.caseDetailsRejectRequestTitle,
      maxWidthMinWidth: MediaQuery.of(context).size.width * .8,
      subTitle: AppLocalizations.of(context)!.caseDetailsRejectRequestConfirmation,
      yesTap: () {
        Navigator.of(context).pop();
        if (participantRole == 'USER_B') {
          _userBRejectApi(caseId);
        } else {
          _userWitnessRejectApi(caseId);
        }
      },
    );
  }
}
