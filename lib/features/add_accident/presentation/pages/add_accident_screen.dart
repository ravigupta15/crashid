import 'dart:io';

import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/core/service/image_picker_service.dart';
import 'package:crashid/features/add_accident/presentation/pages/other_accident_screen.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/app_textfield/custom_dropdown_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/image_picker_bottom_sheet.dart';
import 'package:crashid/features/widgets/app_video_player/app_video_player_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddAccidentScreen extends StatefulWidget {
  
   static void open(BuildContext context) {
    context.push(AppRoutesPath.addAccidentScreen);
  }

  const AddAccidentScreen({super.key});

  @override
  State<AddAccidentScreen> createState() => _AddAccidentScreenState();
}

class _AddAccidentScreenState extends State<AddAccidentScreen> {
 
  // Locally stored files (for later upload).
  final List<File> uploadedPhotos = [];
  File? uploadedVideo;

  // Maximum allowed photos
  final int maxPhotos = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
        title: "Add Accident",
    
      ),
      body: _screenContent(),
    );
  }

  
  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------
 
 Widget _screenContent() {
  return SingleChildScrollView(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select own plate number",
        style: context.titleMedium.copyWith(
          fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5,),
        CustomDropDownFormFiledWidget( 
          borderRadius: 10,
          enableBorderColor: AppColors.blackColor,
        ),
        Padding(padding: EdgeInsets.symmetric(vertical: 13),
        child: Divider(
          color: AppColors.blackColor.withValues(alpha: .2),  
        ),
        ),
        Text("Text Description",  style: context.titleMedium.copyWith(
          fontSize: 14, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 5,),
        AppTextFormField(
          borderRadius: 10,
          hintText: "Describe what happened...",
          maxLines: 3,
        ),
          Padding(padding: EdgeInsets.symmetric(vertical: 13),
        child: Divider(
          color: AppColors.blackColor.withValues(alpha: .2),  
        ),
        ),
      Text("Upload up to 5 Images", style: context.titleMedium.copyWith(
        fontSize: 14, fontWeight: FontWeight.w700
      ),),
      const SizedBox(height: 7,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          maxPhotos,
          (index) => _uploadPhotoWidget(index: index),
        ),
      ),
         Padding(padding: EdgeInsets.symmetric(vertical: 13),
        child: Divider(
          color: AppColors.blackColor.withValues(alpha: .2),  
        ),
        ),
        _recordWidget(),
        const SizedBox(height: 35,),
        Align(
          alignment: Alignment.center,
          child: AppElevatedButton.withTitle(title: "Continue", onPressed: _openOtherAccidentScreen,))
      ],
    ),
  );
 }

  Widget _uploadPhotoWidget({required int index}) {
    final bool hasData = index < uploadedPhotos.length;
    return SizedBox(
      width:55,
      height: 55,
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
                    uploadedPhotos[index],
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
                        "Add Photo",
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

  Future<void> _pickAccidentPhoto({required int index}) async {
    // Prevent adding more than maxPhotos.
    final bool canAddMore = uploadedPhotos.length < maxPhotos;
    if (!canAddMore && index >= uploadedPhotos.length) return;

    final source = await showImageSourcePicker();
    if (source == null) return;

    final File? file = await ImagePickerService.imagePicker(source);
    if (file == null) return;

    setState(() {
      if (index < uploadedPhotos.length) {
        uploadedPhotos[index] = file;
      } else {
        uploadedPhotos.add(file);
      }
    });
  }

  String _fileName(File file) {
    return file.path.split(RegExp(r'[\\/]')).last;
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
                  uploadedVideo == null
                      ? "Click Here to Record Accident"
                      : "Video Selected: ${_fileName(uploadedVideo!)}",
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
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Divider(
          color: AppColors.blackColor.withValues(alpha: .2),
        ),
      ),
      if (uploadedVideo != null)
        AppVideoPlayerWidget(
          videoFile: uploadedVideo,
          height: 220,
        ),
    ],
  );
 }

  Future<void> _pickAccidentVideo() async {
    final source = await showImageSourcePicker();
    if (source == null) return;

    final File? file = await ImagePickerService.videoPicker(source);
    if (file == null) return;

    setState(() {
      uploadedVideo = file;
    });
  }

  // -----------------------------------------------------------------------------
  // Helper Methods
  // -----------------------------------------------------------------------------
 
 void _openOtherAccidentScreen() {
  OtherAccidentScreen.open(context);
 }
}