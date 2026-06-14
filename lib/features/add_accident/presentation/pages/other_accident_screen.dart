import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/service/date_picker_service.dart';
import 'package:crashid/core/service/location_service.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/add_accident/model/other_accident_send_model.dart';
import 'package:crashid/features/add_accident/presentation/widgets/accident_details_widget.dart';
import 'package:crashid/features/add_accident/presentation/widgets/payment_method_widget.dart';
import 'package:crashid/features/add_accident/provider/other_accident_notifier.dart';
import 'package:crashid/features/add_accident/provider/other_accident_state.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/features/widgets/google_map/app_google_map.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/date_format/app_date_format.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OtherAccidentScreen extends ConsumerStatefulWidget {
  static const kCaseId = "/kCaseId";
  static const kRoute = "/kRoute";

  final String? caseId;
  final String? route;

  static Future<void> open(
    BuildContext context, {
    String? caseId,
    String? route,
  }) {
    return context.push(
      AppRoutesPath.otherAccidentScreen,
      extra: {kCaseId: caseId, kRoute: route},
    );
  }

  const OtherAccidentScreen({super.key, this.caseId, this.route});

  @override
  ConsumerState<OtherAccidentScreen> createState() =>
      _OtherAccidentScreenState();
}

class _OtherAccidentScreenState extends ConsumerState<OtherAccidentScreen>
    with AppValidation {
  final _formKey = GlobalKey<FormState>();

  OtherAccidentSendModel? sendModel;

  late DateTime _accidentRecordedAt;

  bool _locationLoading = true;
  String? _locationFailureMessage;

  final otherAccidentNotifierProvider =
      AsyncNotifierProvider<OtherAccidentNotifier, OtherAccidentState>(
        OtherAccidentNotifier.new,
      );

  @override
  void initState() {
    super.initState();
    sendModel = OtherAccidentSendModel(caseId: widget.caseId);
    _accidentRecordedAt = DateTime.now();
    sendModel?.date = AppDateFormat.formatAccidentCardDate(_accidentRecordedAt);
    sendModel?.time = AppDateFormat.formatAccidentCardTime(_accidentRecordedAt);
    _pricingApi();
    _loadAccidentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Add Accident"),
      body: _screenContent(),
    );
  }
  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    final refState = ref.watch(otherAccidentNotifierProvider);
    var model = refState.value?.pricingResponseModel?.data;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Other Driver",
              style: context.titleMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 5),
            AppTextFormField(
              hintText: "Vehicle plate number",
              textCapitalization: TextCapitalization.characters,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                Validator.emojiRestrict(),
                Validator.removeLeadingWhiteSpace(),
                LengthLimitingTextInputFormatter(11),
                GermanPlateInputFormatter(),
              ],
              onSaved: (val) => sendModel?.otherDriver = val,
              validator: (val) {
                if (val == null || val.trim().isEmpty) return null;
                return validateNumberPlate(val);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Divider(color: AppColors.blackColor.withValues(alpha: .2)),
            ),
            Text(
              "Witness",
              style: context.titleMedium.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 5),
            AppTextFormField(
              hintText: "Vehicle plate number",
              textCapitalization: TextCapitalization.characters,
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                Validator.emojiRestrict(),
                Validator.removeLeadingWhiteSpace(),
                LengthLimitingTextInputFormatter(11),
                GermanPlateInputFormatter(),
              ],
              onSaved: (val) => sendModel?.witness = val,
              validator: (val) {
                if (val == null || val.trim().isEmpty) return null;
                return validateNumberPlate(val);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Divider(color: AppColors.blackColor.withValues(alpha: .2)),
            ),
            AccidentDetailsWidget(
              dateValue: AppDateFormat.formatAccidentCardDate(
                _accidentRecordedAt,
              ),
              timeValue: AppDateFormat.formatAccidentCardTime(
                _accidentRecordedAt,
              ),
              locationValue: _locationCardText,
              onDateTap: _pickDate,
              onTimeTap: _pickTime,
              onLocationTap: _openGoogleMapScreen,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 13),
              child: Divider(color: AppColors.blackColor.withValues(alpha: .2)),
            ),
            PaymentMethodWidget(model: model),
            const SizedBox(height: 33),
            Center(
              child: AppElevatedButton.withTitle(
                title: "Add Accident",
                onPressed: _onSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    _formKey.currentState!.save();
    _completeApi();
  }

  void _pricingApi() async {
    await ref.read(otherAccidentNotifierProvider.notifier).pricing();
  }

  void _completeApi() async {
    await ref
        .read(otherAccidentNotifierProvider.notifier)
        .complete(sendModel, route: widget.route);
  }

  String get _locationCardText {
    if (_locationLoading) return 'Getting location…';
    if (_locationFailureMessage != null) return _locationFailureMessage!;
    final addr = sendModel?.currentAddress?.trim();
    if (addr != null && addr.isNotEmpty) return addr;
    return 'Location unavailable';
  }

  Future<void> _loadAccidentLocation() async {
    setState(() {
      _locationLoading = true;
      _locationFailureMessage = null;
    });
    try {
      final data = await LocationService.getCurrentLocationWithAddress();
      sendModel?.currentAddress = data.fullAddress;
      sendModel?.lat = data.latitude.toString();
      sendModel?.lng = data.longitude.toString();
      if (mounted) {
        setState(() => _locationLoading = false);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _locationLoading = false;
        _locationFailureMessage = _messageForLocationFailure(e);
      });
    }
  }

  static String _messageForLocationFailure(Object e) {
    final msg = e.toString().replaceFirst(RegExp(r'^Exception:\s*'), '');
    if (msg.contains('disabled')) {
      return 'Turn on location services to see your address.';
    }
    if (msg.contains('denied')) {
      return 'Location permission is required to show your address.';
    }
    return 'Unable to load location.';
  }

  Future<void> _pickDate() async {
    final pickedDate = await DatePickerService.pickDob(
      context,
      initialDate: _accidentRecordedAt,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _accidentRecordedAt = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          _accidentRecordedAt.hour,
          _accidentRecordedAt.minute,
        );
        sendModel?.date = AppDateFormat.formatAccidentCardDate(
          _accidentRecordedAt,
        );
      });
    }
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_accidentRecordedAt),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: false, // Forces 12-hour UI
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        _accidentRecordedAt = DateTime(
          _accidentRecordedAt.year,
          _accidentRecordedAt.month,
          _accidentRecordedAt.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        sendModel?.time = AppDateFormat.formatAccidentCardTime(
          _accidentRecordedAt,
        );
      });
    }
  }

  Future<void> _openGoogleMapScreen() async {
    GoogleMapAddressScreen.open(
      context,
      lat: sendModel?.lat,
      lng: sendModel?.lng,
    ).then((val) {
        if (val == null) return;
    setState(() {
      _locationLoading = false;
      _locationFailureMessage = null;
      sendModel?.currentAddress = val.fullAddress;
      sendModel?.lat = val.latitude.toString();
      sendModel?.lng = val.longitude.toString();
    });
  
    });
   
  }
}
