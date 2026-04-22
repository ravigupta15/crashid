
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:crashid/utils/validators/validator.dart';

mixin AppValidation {
  String? validatePhoneNumber(String? val) {
    if (val.isNullOrEmpty) {
      return 'Required';
    } else if (val!.length < 10) {
      return "Invalid Number";
    }
    return null;
  }

  String? validateEmail(String? val) {
    if (val.isNullOrEmpty) {
      return 'Required';
    } else if (!Validator.isEmail(val!)) {
      return "Invalid Email";
    }
    return null;
  }

  String? validateEmpty(String? val) {
    if (val.isNullOrEmpty) {
      return 'Required';
    }
    return null;
  }

  String? validateUserNameEmpty(String? val) {
    if (val.isNullOrEmpty) {
      return 'Required';
    } else if ((val ?? '').length <= 3) {
      return 'Required';
    }
    return null;
  }

  String? validatePassword(String? val) {
    if (val.isNullOrEmpty) {
      return 'Required';
    } else if ((val ?? '').length < 8) {
      return 'The password must be at least 8 characters.';
    }
    return null;
  }

  String? validateConfirmPassword(String? val, String? previousPassword) {
    if (val.isNullOrEmpty) {
      return 'Required';
    } else if ((val ?? '').length < 8) {
      return 'Password must be at least 8 characters.';
    } else if (val != previousPassword) {
      return "Password does not match";
    }
    return null;
  }
}
