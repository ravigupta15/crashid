import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/services.dart';

mixin AppValidation {
  static final context = AppRouter.mainNavigatorKey.currentContext;
  
  String? validatePhoneNumber(String? val) {
    if (val.isNullOrEmpty) {
      return AppLocalizations.of(context!)!.required;
    } else if (val!.length < 10) {
      return AppLocalizations.of(context!)!.invalidNumber;
    }
    return null;
  }

  String? validateEmail(String? val) {
    if (val.isNullOrEmpty) {
      return AppLocalizations.of(context!)!.required;
    } else if (!Validator.isEmail(val!)) {
      return AppLocalizations.of(context!)!.invalidEmail;
    }
    return null;
  }

  String? validateNumberPlate(String? val) {
    if (val.isNullOrEmpty) {
      return AppLocalizations.of(context!)!.required;
    } else if (!Validator.vehicleRegExp.hasMatch(val!)) {
      return AppLocalizations.of(context!)!.invalidNumberPlate;
    }
    return null;
  }

  String? validateEmpty(String? val) {
    if (val.isNullOrEmpty) {
      return AppLocalizations.of(context!)!.required;
    }
    return null;
  }

  String? validateUserNameEmpty(String? val) {
    if (val.isNullOrEmpty) {
      return AppLocalizations.of(context!)!.required;
    } else if ((val ?? '').length <= 3) {
      return AppLocalizations.of(context!)!.required;
    }
    return null;
  }

  String? validatePassword(String? val) {
    if (val.isNullOrEmpty) {
      return AppLocalizations.of(context!)!.required;
    } else if ((val ?? '').length < 8) {
      return AppLocalizations.of(context!)!.passcodeLengthInvalid;
    }
    return null;
  }

  String? validateConfirmPassword(String? val, String? previousPassword) {
    if (val.isNullOrEmpty) {
      return AppLocalizations.of(context!)!.required;
    } else if ((val ?? '').length < 8) {
      return AppLocalizations.of(context!)!.passcodeLengthInvalid;
    } else if (val != previousPassword) {
      return AppLocalizations.of(context!)!.passcodeDoesNotMatch;
    }
    return null;
  }
}

/// A formatter that auto-capitalizes and strips out illegal special characters as the user types
class GermanPlateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Force uppercase and strip out anything that isn't a letter, number, or space
    String text = newValue.text.toUpperCase().replaceAll(
      RegExp(r'[^A-Z0-9\s]'),
      '',
    );

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
