import 'dart:io';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ProfileSendModel {
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
  String? contactFirstName;
  String? contactLastName;
  String? jobTitle;
  String? websiteLink;
  String? primaryPhone;
  String? billingAddress;
  String? billingStreet;
  String? billingHouseNumber;
  String? billingPostalCode;
  String? billingCity;
    File? selectedInsurancePdf;
  
  ProfileSendModel({
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
    this.contactFirstName,
    this.contactLastName,
    this.jobTitle,
    this.primaryPhone,
    this.websiteLink,
    this.billingAddress,
    this.billingStreet,
    this.billingHouseNumber,
    this.billingPostalCode,
    this.billingCity,
    this.selectedInsurancePdf,
  });


  Map<String, dynamic> toCompanyMap() {
    return {
      'contact_first_name': contactFirstName,
      'contact_last_name': contactLastName,
      'job_title': jobTitle,
      'date_of_birth': dob,
      'gender': gender,
      'general_email': email,
      'country_code': "+$countryCode",
      'company_phone': mobileNumber,
      'industry': industryType,
      'website_link': websiteLink,
      
      
        'legal_company_name': legalCompanyName,
        'register_company_name': registerCompanyName,
        'general_email': email,
        'country_code': countryCode,
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
      "address": address,
      "street": street,
      "house_number": houseNumber,
      "postal_code": postalCode,
      "city": city,
      "language" : GetIt.I<UserManager>().language,
    };
    return FormData.fromMap(map);
  }
}