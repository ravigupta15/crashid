class RegistrationSendModel {
  String? firstName;
  String? lastName;
  String? dob;
  String? gender;
  String? email;
  String? mobileNumber;
  String? address;
  String? street;
  String? houseNumber;
  String? postalCode;
  String? city;
  bool? termsAccepted;
  bool? privacyAccepted;

  // company 
  String? legalCompanyName;
  String? registerCompanyName;
  String? vitId;
  String? industryType;
  String? password;
  String? confirmPassword;

  RegistrationSendModel({
    this.firstName,
    this.lastName,
    this.dob,
    this.gender,
    this.email,
    this.mobileNumber,
    this.address,
    this.street,
    this.houseNumber,
    this.postalCode,
    this.city,
    this.termsAccepted,
    this.privacyAccepted,

    //company
    this.legalCompanyName,
    this.registerCompanyName,
    this.vitId,
    this.industryType,
    this.password,
    this.confirmPassword,
  });
}