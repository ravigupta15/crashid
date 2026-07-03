import 'dart:io';

import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/service/location_service.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/core/service/image_picker_service.dart';
import 'package:crashid/features/add_accident/model/add_accident_send_model.dart';
import 'package:crashid/features/add_accident/presentation/pages/search_screen.dart';
import 'package:crashid/features/add_accident/presentation/widgets/accident_details_widget.dart';
import 'package:crashid/features/add_accident/provider/add_accident_notifier.dart';
import 'package:crashid/features/add_accident/provider/add_accident_state.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/image_picker_bottom_sheet.dart';
import 'package:crashid/features/widgets/app_video_player/app_video_player_widget.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddAccidentScreen extends ConsumerStatefulWidget {
  static const kRouteName = "/kRouteName";
  static const kcaseId = "/kCaseId";

  final String? routeName;
  final String? caseId;
  static Future<void> open(
    BuildContext context, {
    String? routeName,
    String? caseId,
  }) {
    return context.push(
      AppRoutesPath.addAccidentScreen,
      extra: {kRouteName: routeName, kcaseId: caseId},
    );
  }

  const AddAccidentScreen({super.key, this.routeName, this.caseId});

  @override
  ConsumerState<AddAccidentScreen> createState() => _AddAccidentScreenState();
}

class _AddAccidentScreenState extends ConsumerState<AddAccidentScreen>
    with AppValidation {
  // Locally stored files (for later upload).

  // Maximum allowed photos
  final int maxPhotos = 5;

  final formKey = GlobalKey<FormState>();

  late DateTime _accidentRecordedAt;

  AddAccidentSendModel? sendModel;

  final addAccidentNotifierProvider =
      AsyncNotifierProvider<AddAccidentNotifier, AddAccidentState>(
        AddAccidentNotifier.new,
      );

  @override
  void initState() {
    sendModel = AddAccidentSendModel(uploadedPhotos: [], caseId: widget.caseId);
    if (widget.routeName == 'accept') {
      _accidentRecordedAt = DateTime.now();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.addAccident),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((widget.routeName ?? '') != 'accept') ...[
              Text(
                AppLocalizations.of(context)!.selectOwnPlateNumber,
                style: context.titleMedium.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              AppTextFormField(
                borderRadius: 10,
                isReadOnly: true,
                onTap: _openSearchScreen,
                controller: TextEditingController(
                  text: sendModel?.model?.plateNumber,
                ),
                enableBorderColor: AppColors.blackColor,
                suffixIcon: Icon(Icons.keyboard_arrow_down),
                validator: validateEmpty,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 13),
                child: Divider(
                  color: AppColors.blackColor.withValues(alpha: .2),
                ),
              ),
            ],
            Text(
              AppLocalizations.of(context)!.textDescription,
              style: context.titleMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            AppTextFormField(
              borderRadius: 10,
              hintText: AppLocalizations.of(context)!.describeWhatHappened,
              maxLines: 3,
              inputFormatters: [Validator.removeLeadingWhiteSpace()],
              onSaved: _saveDes,
              validator: validateEmpty,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Divider(color: AppColors.blackColor.withValues(alpha: .2)),
            ),
            Text(
              AppLocalizations.of(context)!.uploadUpTo5Images,
              style: context.titleMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                maxPhotos,
                (index) => _uploadPhotoWidget(index: index),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Divider(color: AppColors.blackColor.withValues(alpha: .2)),
            ),
            _recordWidget(),

            if (widget.routeName == 'accept') ...[
              AccidentDetailsWidget(
                dateValue: AppDateFormat.formatAccidentCardDate(
                  _accidentRecordedAt,
                ),
                timeValue: AppDateFormat.formatAccidentCardTime(
                  _accidentRecordedAt,
                ),
                locationValue: '',
                shouldShowLocation: false,
              ),
            ],
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.center,
              child: AppElevatedButton.withTitle(
                title: AppLocalizations.of(context)!.continueTitle,
                onPressed: widget.routeName == 'accept'
                    ? _acceptUserBApi
                    : _checkValidation,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _uploadPhotoWidget({required int index}) {
    final bool hasData = index < (sendModel?.uploadedPhotos ?? []).length;
    return SizedBox(
      width: 57,
      height: 62,
      child: InkWell(
        onTap: () => _pickAccidentPhoto(index: index),
        child: hasData
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    (sendModel?.uploadedPhotos ?? [])[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  strokeWidth: 1,
                  color: AppColors.lightGrayColor,
                  radius: Radius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt_outlined, size: 22),
                      Text(
                          AppLocalizations.of(context)!.addPhoto,
                          textAlign: TextAlign.center,
                        style: context.bodyMedium.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _recordWidget() {
    return Column(
      children: [
        InkWell(
          onTap: _pickAccidentVideo,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGrayColor),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Image.asset(AppAssetPaths.videoCameraIcon),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    sendModel?.uploadedVideo == null
                        ? AppLocalizations.of(context)!.clickHereToRecordAccident
                        : "${AppLocalizations.of(context)!.videoSelected} ${_fileName(sendModel?.uploadedVideo)}",
                    style: context.titleMedium.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (sendModel?.uploadedVideo != null)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: AppVideoPlayerWidget(
              videoFile: sendModel?.uploadedVideo,
              height: 220,
              showFullScreenButton: true,
            ),
          ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Divider(color: AppColors.blackColor.withValues(alpha: .2)),
        ),
      ],
    );
  }

  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------

  void _addAccidentApi() async {
    await ref.read(addAccidentNotifierProvider.notifier).addAccident(sendModel);
  }

  void _acceptUserBApi() async {
    await ref.read(addAccidentNotifierProvider.notifier).userBAccept(sendModel);
  }

  void _openSearchScreen() {
    SearchScreen.open(context, sendModel?.model).then((val) {
      sendModel?.model = val;
      setState(() {});
    });
  }

  void _checkValidation() {
    if (formKey.currentState!.validate()) {
      if ((sendModel?.uploadedPhotos ?? []).isEmpty) {
        return showFeedbackMessage(AppLocalizations.of(context)!.pleaseUploadPhotos);
      } 
      // else if (sendModel?.uploadedVideo == null) {
      //   return showFeedbackMessage("Please upload the video");
      // }
      formKey.currentState!.save();
      _addAccidentApi();
    }
  }

  void _saveDes(String? val) {
    sendModel?.des = val;
  }

  Future<void> _pickAccidentPhoto({required int index}) async {
    // Prevent adding more than maxPhotos.
    final bool canAddMore =
        (sendModel?.uploadedPhotos ?? []).length < maxPhotos;
    if (!canAddMore && index >= (sendModel?.uploadedPhotos ?? []).length)
      return;

    final source = await showImageSourcePicker();
    if (source == null) return;

    final File? file = await ImagePickerService.imagePicker(source);
    if (file == null) return;

    setState(() {
      if (index < (sendModel?.uploadedPhotos ?? []).length) {
        sendModel?.uploadedPhotos?[index] = file;
      } else {
        sendModel?.uploadedPhotos?.add(file);
      }
    });
  }

  String _fileName(File? file) {
    return file!.path.split(RegExp(r'[\\/]')).last;
  }

  Future<void> _pickAccidentVideo() async {
    final source = await showImageSourcePicker();
    if (source == null) return;

    final File? file = await ImagePickerService.videoPicker(source);
    if (file == null) return;

    setState(() {
      sendModel?.uploadedVideo = file;
    });
  }
}
