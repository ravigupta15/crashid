import 'dart:io';
import 'package:dio/dio.dart';

class RegistrationSendModel {
  String? accountType;
  String? firstName;
  String? lastName;
  String? dob;
  String? gender;
  String? email;
  String? countryCode;
  String? mobileNumber;
  String? address;
  String? street;
  String? houseNumber;
  String? postalCode;
  String? city;
  bool? termsAccepted;
  bool? privacyAccepted;
  File? drivingLicenseFront;
  File? drivingLicenseBack;
  File? idDocumentFront;
  File? idDocumentBack;
  // company 
  String? legalCompanyName;
  String? registerCompanyName;
  String? vitId;
  String? industryType;
  String? password;
  String? confirmPassword;

  RegistrationSendModel({
    this.accountType,
    this.firstName,
    this.lastName,
    this.dob,
    this.gender,
    this.email,
    this.countryCode,
    this.mobileNumber,
    this.address,
    this.street,
    this.houseNumber,
    this.postalCode,
    this.city,
    this.termsAccepted,
    this.privacyAccepted,
    this.drivingLicenseFront,
    this.drivingLicenseBack,
    this.idDocumentFront,
    this.idDocumentBack,

    //company
    this.legalCompanyName,
    this.registerCompanyName,
    this.vitId,
    this.industryType,
    this.password,
    this.confirmPassword,
  });


  Map<String, dynamic> toCompanyMap() {
    return {
        'legal_company_name': legalCompanyName,
        'register_company_name': registerCompanyName,
        'general_email': email,
        'country_code': "+$countryCode",
        'company_phone': mobileNumber,
        'vat_id': vitId,
        'industry': industryType,
        'password': password,
        'confirm_password': confirmPassword,
        'terms_accepted': termsAccepted,
        'privacy_accepted': privacyAccepted,
      };
  }

  Future<FormData> toFormData() async {
    Map<String, dynamic> map = {
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dob,
      "gender": gender,
      "email": email,
      "country_code": "+$countryCode",
      "mobile_number": mobileNumber,
      "password": password,
      "confirm_password": confirmPassword,
      "address": address,
      "street": street,
      "house_number": houseNumber,
      "postal_code": postalCode,
      "city": city,
      "terms_accepted": termsAccepted,
      "privacy_accepted": privacyAccepted,

    };

    // Handle Files - Only add if they are not null
    if (drivingLicenseFront != null) {
      map["driving_license_front"] = await MultipartFile.fromFile(drivingLicenseFront!.path);
    }
    if (drivingLicenseBack != null) {
      map["driving_license_back"] = await MultipartFile.fromFile(drivingLicenseBack!.path);
    }
    if (idDocumentFront != null) {
      map["id_document_front"] = await MultipartFile.fromFile(idDocumentFront!.path);
    }
    if (idDocumentBack != null) {
      map["id_document_back"] = await MultipartFile.fromFile(idDocumentBack!.path);
    }

    return FormData.fromMap(map);
  }
}