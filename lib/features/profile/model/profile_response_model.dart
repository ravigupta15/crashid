class ProfileResponseModel {
  bool? success;
  String? message;
  ProfileModel? data;

  ProfileResponseModel({this.success, this.message, this.data});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  ProfileModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileModel {
  dynamic id;
  dynamic accountType;
  dynamic email;
  dynamic countryCode;
  dynamic mobileNumber;
  dynamic profileImage;
  dynamic language;
  dynamic status;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  dynamic firstName;
  dynamic lastName;
  dynamic dateOfBirth;
  dynamic gender;
  dynamic legalCompanyName;
  dynamic registeredCompanyName;
  dynamic legalFormPdf;
  dynamic generalEmail;
  dynamic companyPhone;
  dynamic industry;
  dynamic companySize;
  dynamic commercialRegistrationNumber;
  dynamic vatId;
  dynamic websiteLink;
  dynamic contactFirstName;
  dynamic contactLastName;
  dynamic jobTitle;
  dynamic businessAddress;
  dynamic billingAddress;
  dynamic drivingLicenseFront;
  dynamic drivingLicenseBack;
  dynamic idDocumentFront;
  dynamic idDocumentBack;
  dynamic address;
  dynamic street;
  dynamic houseNumber;
  dynamic postalCode;
  dynamic city;
  dynamic contactCountryCode;
  dynamic contactPhone;
  dynamic contactEmail;

  ProfileModel(
      {this.id,
      this.accountType,
      this.email,
      this.countryCode,
      this.mobileNumber,
      this.profileImage,
      this.language,
      this.status,
      this.emailVerifiedAt,
      this.createdAt,
      this.firstName,
      this.lastName,
      this.dateOfBirth,
      this.gender,
      this.legalCompanyName,
      this.registeredCompanyName,
      this.legalFormPdf,
      this.generalEmail,
      this.companyPhone,
      this.industry,
      this.companySize,
      this.commercialRegistrationNumber,
      this.vatId,
      this.websiteLink,
      this.contactFirstName,
      this.contactLastName,
      this.jobTitle,
      this.businessAddress,
      this.billingAddress,
      this.drivingLicenseFront,
      this.drivingLicenseBack,
      this.idDocumentFront,
      this.idDocumentBack,
      this.address,
      this.street,
      this.houseNumber,
      this.postalCode,
      this.city,
      this.contactCountryCode,
      this.contactPhone,
      this.contactEmail});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountType = json['account_type'];
    email = json['email'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    profileImage = json['profile_image'];
    language = json['language'];
    status = json['status'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    legalCompanyName = json['legal_company_name'];
    registeredCompanyName = json['registered_company_name'];
    legalFormPdf = json['legal_form_pdf'];
    generalEmail = json['general_email'];
    companyPhone = json['company_phone'];
    industry = json['industry'];
    companySize = json['company_size'];
    commercialRegistrationNumber = json['commercial_registration_number'];
    vatId = json['vat_id'];
    websiteLink = json['website_link'];
    contactFirstName = json['contact_first_name'];
    contactLastName = json['contact_last_name'];
    jobTitle = json['job_title'];
    businessAddress = json['business_address'];
    billingAddress = json['billing_address'];
    drivingLicenseFront = json['driving_license_front_url'];
    drivingLicenseBack = json['driving_license_back_url'];
    idDocumentFront = json['id_document_front_url'];
    idDocumentBack = json['id_document_back_url'];
    address = json['address'];
    street = json['street'];
    houseNumber = json['house_number'];
    postalCode = json['postal_code'];
    city = json['city'];
    contactCountryCode = json['contact_country_code'];
    contactPhone = json['contact_phone'];
    contactEmail = json['contact_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['account_type'] = accountType;
    data['email'] = email;
    data['country_code'] = countryCode;
    data['mobile_number'] = mobileNumber;
    data['profile_image'] = profileImage;
    data['language'] = language;
    data['status'] = status;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['legal_company_name'] = legalCompanyName;
    data['registered_company_name'] = registeredCompanyName;
    data['legal_form_pdf'] = legalFormPdf;
    data['general_email'] = generalEmail;
    data['company_phone'] = companyPhone;
    data['industry'] = industry;
    data['company_size'] = companySize;
    data['commercial_registration_number'] = commercialRegistrationNumber;
    data['vat_id'] = vatId;
    data['website_link'] = websiteLink;
    data['contact_first_name'] = contactFirstName;
    data['contact_last_name'] = contactLastName;
    data['job_title'] = jobTitle;
     data['business_address'] = businessAddress;
    data['billing_address'] = billingAddress;

    data['driving_license_front_url'] = drivingLicenseFront;
    data['driving_license_back_url'] = drivingLicenseBack;
    data['id_document_front_url'] = idDocumentFront;
    data['id_document_back_url'] = idDocumentBack;
    data['address'] = address;
    data['street'] = street;
    data['house_number'] = houseNumber;
    data['postal_code'] = postalCode;
    data['city'] = city;
    data['contact_country_code'] = contactCountryCode;
    data['contact_phone'] = contactPhone;
    data['contact_email'] = contactEmail;
    return data;
  }
}
