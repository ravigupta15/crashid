import 'dart:io';

import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/service/date_picker_service.dart';
import 'package:crashid/core/service/image_picker_service.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/core/widget/app_dropdown_item_widget.dart';
import 'package:crashid/features/add_car/model/add_car_send_model.dart';
import 'package:crashid/features/add_car/provider/add_car_notifier.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/app_textfield/custom_dropdown_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, LengthLimitingTextInputFormatter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddCarScreen extends ConsumerStatefulWidget {
  static Future<void> open(BuildContext context) {
    return context.push(AppRoutesPath.addCarScreen);
  }

  const AddCarScreen({super.key});

  @override
  ConsumerState<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends ConsumerState<AddCarScreen>
    with AppValidation {
  final _formKey = GlobalKey<FormState>();
  AddCarSendModel? sendModel;
  final _registrationDateController = TextEditingController();
  final _tuevDateController = TextEditingController();
  final _insuranceStartDateController = TextEditingController();
  final _insuranceEndDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sendModel = AddCarSendModel(selectedCarImages: []);
    _callInitFunction();
  }

  void _callInitFunction() {
    ref.read(addCarNotifierProvider.notifier).carBrands(context);
    ref.read(addCarNotifierProvider.notifier).carColors();
    ref.read(addCarNotifierProvider.notifier).insurance();
  }

  @override
  void dispose() {
    _registrationDateController.dispose();
    _tuevDateController.dispose();
    _insuranceStartDateController.dispose();
    _insuranceEndDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.addCarTitle),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    final addCarState = ref.watch(addCarNotifierProvider);
    final brands = (addCarState.value?.brandsModel?.data ?? [])
        .map(
          (brand) =>
              CustomDropDownItem(key: '${brand.id}', value: '${brand.name}'),
        )
        .toList();
    final models = (addCarState.value?.mdModel?.data ?? [])
        .map(
          (model) =>
              CustomDropDownItem(key: '${model.id}', value: '${model.name}'),
        )
        .toList();
    final colors = (addCarState.value?.colorsModel?.data ?? [])
        .map(
          (color) =>
              CustomDropDownItem(key: '${color.id}', value: '${color.name}'),
        )
        .toList();

    final insuranceCompanies = AppDropdownItemWidget.insuranceCompanies(
      addCarState.value?.insuranceResponseModel?.data,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            AppTextFormField(
              hintText: "Plate Number",
              initialValue: sendModel?.plateNumber,
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                Validator.emojiRestrict(),
                Validator.removeLeadingWhiteSpace(),
                LengthLimitingTextInputFormatter(11),
                GermanPlateInputFormatter(),
              ],
              validator: validateNumberPlate,
              onSaved: (value) => sendModel?.plateNumber = value?.trim(),
            ),
            const SizedBox(height: 20),
            CustomDropDownFormFiledWidget(
              hintText: "Brand",
              items: brands,
              initialValue: _selectedItem(brands, sendModel?.brand),
              validator: _validateDropdown,
              onChanged: (value) async {
                if (value == null) return;
                setState(() {
                  sendModel?.brand = value.key;
                  sendModel?.model = null;
                });
                await ref
                    .read(addCarNotifierProvider.notifier)
                    .carModels(context, model: sendModel);
              },
            ),
            const SizedBox(height: 20),
            CustomDropDownFormFiledWidget(
              hintText: "Model",
              items: models,
              initialValue: _selectedItem(models, sendModel?.model),
              validator: _validateDropdown,
              onChanged: (value) => sendModel?.model = value?.key,
            ),
            // const SizedBox(height: 20),
            // AppTextFormField(
            //   hintText: "Car Name",
            //   inputFormatters: [
            //     Validator.emojiRestrict(),
            //     Validator.removeLeadingWhiteSpace(),
            //   ],
            //   validator: validateEmpty,
            //   onChanged: (value) => sendModel?.carName = value,
            //   textInputAction: TextInputAction.next,
            // ),
            const SizedBox(height: 20),
            CustomDropDownFormFiledWidget(
              hintText: "Fuel Type",
              items: AppDropdownItemWidget.fuelTypes,
              initialValue: _selectedItem(
                AppDropdownItemWidget.fuelTypes,
                sendModel?.fuelType,
              ),
              validator: _validateDropdown,
              onChanged: (value) => sendModel?.fuelType = value?.value,
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              hintText: "Registration date from",
              controller: _registrationDateController,
              textColor: AppColors.darkGrayColor,
              isReadOnly: true,
              textInputAction: TextInputAction.next,
              validator: validateEmpty,
              onTap: () => _pickDate(_registrationDateController),
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              hintText: "HP/PS",
              initialValue: sendModel?.hpPs,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
              inputFormatters: [
                Validator.removeLeadingWhiteSpace(),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: validateEmpty,
              onSaved: (value) => sendModel?.hpPs = value?.trim(),
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              hintText: "Mileage",
              initialValue: sendModel?.mileage,
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                Validator.removeLeadingWhiteSpace(),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: validateEmpty,
              onSaved: (value) => sendModel?.mileage = value?.trim(),
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              hintText: "TÜV Date",
              controller: _tuevDateController,
              textColor: AppColors.darkGrayColor,
              isReadOnly: true,
              textInputAction: TextInputAction.next,
              validator: validateEmpty,
              onTap: () => _pickDate(_tuevDateController),
            ),
            const SizedBox(height: 20),
            CustomDropDownFormFiledWidget(
              hintText: "Color",
              items: colors,
              initialValue: _selectedItem(colors, sendModel?.color),
              validator: _validateDropdown,
              onChanged: (value) => sendModel?.color = value?.key,
            ),
            const SizedBox(height: 20),
            AppTextFormField(
              hintText: 'FIN/VIN',
              initialValue: sendModel?.vinNumber,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                Validator.emojiRestrict(),
                Validator.removeLeadingWhiteSpace(),
              ],
              validator: validateEmpty,
              onSaved: (value) => sendModel?.vinNumber = value?.trim(),
            ),
            const SizedBox(height: 20),
            _buildUploadField(title: 'Car Image', onTap: _pickCarImages),
            if (sendModel?.selectedCarImages.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              _selectedCarImagesWidget(),
            ],
            const SizedBox(height: 20),
            CustomDropDownFormFiledWidget(
              items: insuranceCompanies,
              hintText: 'Insurance Company',
              validator: _validateDropdown,
              initialValue: _selectedItem(
                insuranceCompanies,
                sendModel?.insuranceCompany,
              ),
              onChanged: (value) {
                setState(() {
                  sendModel?.insuranceCompany = value?.value;
                });
              },
            ),

            const SizedBox(height: 20),
            AppTextFormField(
              hintText: "Insurance Email Address",
              prefixIcon: Image.asset(
                AppAssetPaths.mailIcon,
                height: 12,
                width: 16,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(Validator.regEmail),
              ],
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              initialValue: sendModel?.insuranceEmail,
              validator: validateEmail,
              onSaved: (value) => sendModel?.insuranceEmail = value?.trim(),
            ),

            const SizedBox(height: 20),
            AppTextFormField(
              hintText: 'Insurance Number',
              initialValue: sendModel?.insuranceNumber,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                Validator.emojiRestrict(),
                Validator.removeLeadingWhiteSpace(),
              ],
              validator: validateEmpty,
              onSaved: (value) => sendModel?.insuranceNumber = value?.trim(),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: AppTextFormField(
                    hintText: 'Valid From',
                    controller: _insuranceStartDateController,
                    textColor: AppColors.darkGrayColor,
                    isReadOnly: true,
                    validator: validateEmpty,
                    onTap: _pickInsuranceStartDate,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '—',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor.withValues(alpha: .5),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextFormField(
                    hintText: 'Valid To',
                    controller: _insuranceEndDateController,
                    textColor: AppColors.darkGrayColor,
                    isReadOnly: true,
                    validator: validateEmpty,
                    onTap: _pickInsuranceEndDate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildUploadField(
              title: sendModel?.selectedInsurancePdf == null
                  ? 'Insurance PDF'
                  : _fileNameFromPath(sendModel!.selectedInsurancePdf!.path),
              onTap: _pickInsurancePdf,
            ),
            if (sendModel?.selectedInsurancePdf != null) ...[
              const SizedBox(height: 10),
              _selectedPdfWidget(),
            ],
            const SizedBox(height: 20),
            _buildUploadField(
              title: sendModel?.selectedTuevReportPdf == null
                  ? 'TÜV Report (Optional)'
                  : _fileNameFromPath(sendModel!.selectedTuevReportPdf!.path),
              onTap: _pickTuevReport,
            ),
            if (sendModel?.selectedTuevReportPdf != null) ...[
              const SizedBox(height: 10),
              _selectedTuevReportWidget(),
            ],
            const SizedBox(height: 20),
            AppElevatedButton.withTitle(
              title: AppLocalizations.of(context)!.addCarTitle,
              onPressed: _submitAddCar,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadField({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.lightGrayColor),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: context.bodyMedium.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGrayColor.withValues(alpha: .6),
                ),
              ),
            ),
            Center(
              child: Image.asset(
                AppAssetPaths.uploadIcon,
                width: 50,
                height: 38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _selectedCarImagesWidget() {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sendModel?.selectedCarImages.length ?? 0,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final image = sendModel?.selectedCarImages[index];
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  image!,
                  width: 86,
                  height: 86,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: InkWell(
                  onTap: () => _removeCarImage(index),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _selectedPdfWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf, color: AppColors.primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _fileNameFromPath(sendModel?.selectedInsurancePdf?.path ?? ''),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrayColor,
              ),
            ),
          ),
          InkWell(
            onTap: _removeInsurancePdf,
            child: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }

  CustomDropDownItem? _selectedItem(
    List<CustomDropDownItem> list,
    String? value,
  ) {
    if (value == null) return null;
    for (final item in list) {
      if (item.key == value || item.value == value) return item;
    }
    return null;
  }

  String? _validateDropdown(CustomDropDownItem? value) {
    if (value == null) return 'Required';
    return null;
  }

  Future<void> _submitAddCar() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (sendModel?.selectedCarImages.isEmpty == true) {
      showFeedbackMessage(
        'Please upload at least one car image.',
        context: context,
      );
      return;
    }
    if (sendModel?.selectedInsurancePdf == null) {
      showFeedbackMessage('Please upload insurance PDF.', context: context);
      return;
    }
    _formKey.currentState!.save();
    sendModel?.registrationDateFrom = _registrationDateController.text.trim();
    sendModel?.tuevDate = _tuevDateController.text.trim();
    sendModel?.insuranceStartDate = _insuranceStartDateController.text.trim();
    sendModel?.insuranceEndDate = _insuranceEndDateController.text.trim();
    await ref
        .read(addCarNotifierProvider.notifier)
        .addCar(context, model: sendModel);
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final pickedDate = await DatePickerService.pickDob(
      context,
      previousYearLimit: DateTime.now().year,
      lastDate: DateTime(2100),
      initialDate: controller.text.isEmpty
          ? null
          : _parseCurrentText(controller.text),
    );
    if (pickedDate == null) return;
    setState(() {
      controller.text = DatePickerService.formatForDisplay(pickedDate);
    });
  }

  Future<void> _pickInsuranceStartDate() async {
    final pickedDate = await DatePickerService.pickDob(
      context,
      previousYearLimit: DateTime.now().year,
      lastDate: DateTime(2100),
      initialDate: _insuranceStartDateController.text.isEmpty
          ? null
          : _parseCurrentText(_insuranceStartDateController.text),
    );
    if (pickedDate == null) return;
    setState(() {
      _insuranceStartDateController.text = DatePickerService.formatForDisplay(
        pickedDate,
      );
      final currentEndDate = _parseCurrentText(
        _insuranceEndDateController.text,
      );
      if (currentEndDate != null && currentEndDate.isBefore(pickedDate)) {
        _insuranceEndDateController.clear();
      }
    });
  }

  Future<void> _pickInsuranceEndDate() async {
    final startDate = _parseCurrentText(_insuranceStartDateController.text);
    if (startDate == null) {
      showFeedbackMessage(
        'Please select Valid From date first.',
        context: context,
      );
      return;
    }

    final initialDate = _insuranceEndDateController.text.isEmpty
        ? startDate
        : _parseCurrentText(_insuranceEndDateController.text) ?? startDate;

    print(startDate);
    final pickedDate = await DatePickerService.pickDob(
      context,
      firstDate: startDate,
      lastDate: DateTime(2100),
      initialDate: initialDate.isBefore(startDate) ? startDate : initialDate,
    );

    if (pickedDate == null) return;
    setState(() {
      _insuranceEndDateController.text = DatePickerService.formatForDisplay(
        pickedDate,
      );
    });
  }

  Future<void> _pickCarImages() async {
    if ((sendModel?.selectedCarImages ?? []).length >= 5) {
      showFeedbackMessage(
        'You can upload up to 5 car images.',
        context: context,
      );
      return;
    }

    final files = await ImagePickerService.pickMultipleImagesFromGallery();
    if (files.isEmpty) return;
    final availableSlots = 5 - (sendModel?.selectedCarImages.length ?? 0);
    final filesToAdd = files.take(availableSlots).toList();
    setState(() {
      sendModel?.selectedCarImages.addAll(filesToAdd);
    });
    if (files.length > availableSlots && context.mounted) {
      showFeedbackMessage(
        'Only 5 images are allowed. Extra images were ignored.',
        context: context,
      );
    }
  }

  Future<void> _pickInsurancePdf() async {
    final file = await ImagePickerService.pickPdfFile();
    if (file == null) return;
    setState(() {
      sendModel?.selectedInsurancePdf = file;
    });
  }

  Future<void> _pickTuevReport() async {
    final file = await ImagePickerService.pickPdfFile();
    if (file == null) return;
    setState(() {
      sendModel?.selectedTuevReportPdf = file;
    });
  }

  Widget _selectedTuevReportWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrayColor),
      ),
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf, color: AppColors.primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _fileNameFromPath(sendModel?.selectedTuevReportPdf?.path ?? ''),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.bodyMedium.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrayColor,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                sendModel?.selectedTuevReportPdf = null;
              });
            },
            child: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }

  void _removeCarImage(int index) {
    setState(() {
      sendModel?.selectedCarImages.removeAt(index);
    });
  }

  void _removeInsurancePdf() {
    setState(() {
      sendModel?.selectedInsurancePdf = null;
    });
  }

  String _fileNameFromPath(String path) {
    if (path.isEmpty) return '';
    return path.split(Platform.pathSeparator).last;
  }

  DateTime? _parseCurrentText(String text) {
    if (text.isEmpty) return null;
    try {
      final parts = text.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
      return DateTime.parse(text);
    } catch (e) {
      debugPrint("Could not parse date: $e");
      return null;
    }
  }
}
