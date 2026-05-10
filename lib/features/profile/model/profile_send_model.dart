import 'dart:io';
import 'package:crashid/data_sources/local_storage/user_manager.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ProfileSendModel {
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

 // url
 String? drivingLicenseFrontUrl;
 String? drivingLicenseBackUrl;
 String? idDocumentFrontUrl;
 String? idDocumentBackUrl;

  // company 
  String? legalCompanyName;
  String? registerCompanyName;
  String? commercialRegNumber;
  String? vitId;
  String? industryType;
  String? password;
  String? confirmPassword;
  String? contactFirstName;
  String? contactLastName;
  String? jobTitle;
  String? websiteLink;
  String? contactEmail;
  String? contactPhone;

 
  String? businessAddress;
  String? businessStreet;
  String? businessHouseNumber;
  String? businessPostalCode;
  String? businessCity;

  String? billingAddress;
  String? billingStreet;
  String? billingHouseNumber;
  String? billingPostalCode;
  String? billingCity;
  File? selectedInsurancePdf;
  
  ProfileSendModel({
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
    
    // url
    this.drivingLicenseFrontUrl,
    this.drivingLicenseBackUrl,
    this.idDocumentFrontUrl,
    this.idDocumentBackUrl,

    //company
    this.legalCompanyName,
    this.registerCompanyName,
    this.commercialRegNumber,
    this.vitId,
    this.industryType,
    this.password,
    this.confirmPassword,
    this.contactFirstName,
    this.contactLastName,
    this.contactEmail,
    this.jobTitle,
    this.contactPhone,
    this.websiteLink,

    this.businessAddress,
    this.businessStreet,
    this.businessHouseNumber,
    this.businessPostalCode,
    this.businessCity,

    this.billingAddress,
    this.billingStreet,
    this.billingHouseNumber,
    this.billingPostalCode,
    this.billingCity,
    this.selectedInsurancePdf,
  });


  Future<FormData> toCompanyMap() async{
    Map <String, dynamic> map = {
      'legal_company_name': legalCompanyName,
      'register_company_name': registerCompanyName,
      'commercial_registration_number':commercialRegNumber,
      'vat_id': vitId,
      'general_email': email,
      'country_code': "+$countryCode",
      'company_phone': mobileNumber,
      'website_link': websiteLink,
      'contact_first_name': contactFirstName,
      'contact_last_name': contactLastName,
      'job_title': jobTitle,
      'contact_email': contactEmail,
      'contact_country_code': "+$countryCode",
      'contact_phone': contactPhone,
      'date_of_birth': dob,
      'gender': gender,
      'industry': industryType,
      'language':GetIt.I<UserManager>().language,
      'business_address': businessAddress,
      'business_street': businessStreet,
      'business_house_number': businessHouseNumber,
      'business_postal_code': businessPostalCode,
      'business_city': businessCity,

      'billing_address': billingAddress,
      'billing_street': billingStreet,
      'billing_house_number': billingHouseNumber,
      'billing_postal_code': billingPostalCode,
      'billing_city': billingCity
    
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

    if (selectedInsurancePdf != null) {
      map['legal_form_pdf'] = await MultipartFile.fromFile(selectedInsurancePdf!.path);
    }

    return FormData.fromMap(map);
       
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