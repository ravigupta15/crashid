import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get german;

  /// No description provided for @continueTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueTitle;

  /// No description provided for @selectLangauge.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLangauge;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language to continue'**
  String get chooseLanguage;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Add Your Car'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDes1.
  ///
  /// In en, this message translates to:
  /// **'Enter your car details like model, year, and registration number to manage your vehicle and get accurate support when needed.'**
  String get onboardingDes1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Add Insurance'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDes2.
  ///
  /// In en, this message translates to:
  /// **'Save your insurance provider, policy number, and expiry date so we can quickly assist you with claims and support.'**
  String get onboardingDes2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Report Accidents Faster'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDes3.
  ///
  /// In en, this message translates to:
  /// **'Quickly report accidents by adding photos, location, and details. We’ll notify your insurance company and help speed up the process.'**
  String get onboardingDes3;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your Email!'**
  String get checkYourEmail;

  /// No description provided for @otpSentDescription.
  ///
  /// In en, this message translates to:
  /// **'Your OTP has been sent successfully. \nvalid for 10 minutes.'**
  String get otpSentDescription;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Your password must be different from\npreviously used passwords'**
  String get resetPasswordDescription;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Comfirm Password'**
  String get confirmPassword;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordButton;

  /// No description provided for @passwordChangedTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Changed'**
  String get passwordChangedTitle;

  /// No description provided for @passwordChangedDescription.
  ///
  /// In en, this message translates to:
  /// **'Your account password has been updated,\nyou can already login with your new password.'**
  String get passwordChangedDescription;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @acceptTermsMessage.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms & conditions and the privacy policy.'**
  String get acceptTermsMessage;

  /// No description provided for @personalAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Account'**
  String get personalAccountTitle;

  /// No description provided for @personalAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For individual drivers and car owners.'**
  String get personalAccountSubtitle;

  /// No description provided for @companyAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Company Account'**
  String get companyAccountTitle;

  /// No description provided for @companyAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For businesses and fleet management.'**
  String get companyAccountSubtitle;

  /// No description provided for @personalAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'For individual users managing their own car, insurance, and accident reports.'**
  String get personalAccountDescription;

  /// No description provided for @companyAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'For businesses managing multiple vehicles, drivers, and insurance processes.'**
  String get companyAccountDescription;

  /// No description provided for @personalRegistrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal Registration'**
  String get personalRegistrationTitle;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'DD/MM/YY'**
  String get dateOfBirth;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileNumber;

  /// No description provided for @drivingLicenseFront.
  ///
  /// In en, this message translates to:
  /// **'Driving License Front'**
  String get drivingLicenseFront;

  /// No description provided for @drivingLicenseBack.
  ///
  /// In en, this message translates to:
  /// **'Driving License Back'**
  String get drivingLicenseBack;

  /// No description provided for @idDocumentFront.
  ///
  /// In en, this message translates to:
  /// **'ID Document Front'**
  String get idDocumentFront;

  /// No description provided for @idDocumentBack.
  ///
  /// In en, this message translates to:
  /// **'ID Document Back'**
  String get idDocumentBack;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @street.
  ///
  /// In en, this message translates to:
  /// **'Street'**
  String get street;

  /// No description provided for @houseNumber.
  ///
  /// In en, this message translates to:
  /// **'House Number'**
  String get houseNumber;

  /// No description provided for @postalCode.
  ///
  /// In en, this message translates to:
  /// **'Postal Code'**
  String get postalCode;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @termsAndConditionsAcceptance.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions Acceptance'**
  String get termsAndConditionsAcceptance;

  /// No description provided for @privacyPolicyAcceptance.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy Acceptance'**
  String get privacyPolicyAcceptance;

  /// No description provided for @termsConditionAndThePrivcyPolicy.
  ///
  /// In en, this message translates to:
  /// **'terms & conditions and the privacy policy'**
  String get termsConditionAndThePrivcyPolicy;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already Have an Account?'**
  String get alreadyHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @addCarTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Car'**
  String get addCarTitle;

  /// No description provided for @myCarsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Cars'**
  String get myCarsTitle;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @companyRegistrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Company Registration'**
  String get companyRegistrationTitle;

  /// No description provided for @legalCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Legal Company Name'**
  String get legalCompanyName;

  /// No description provided for @registeredCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Registered Company Name (Optional)'**
  String get registeredCompanyName;

  /// No description provided for @generalCompanyEmail.
  ///
  /// In en, this message translates to:
  /// **'General Company Email'**
  String get generalCompanyEmail;

  /// No description provided for @companyPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Company Phone Number'**
  String get companyPhoneNumber;

  /// No description provided for @vitId.
  ///
  /// In en, this message translates to:
  /// **'VIT ID'**
  String get vitId;

  /// No description provided for @industryType.
  ///
  /// In en, this message translates to:
  /// **'Industry Type'**
  String get industryType;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @pleaseAcceptTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms and conditions.'**
  String get pleaseAcceptTermsAndConditions;

  /// No description provided for @pleaseAcceptPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Please accept the privacy policy.'**
  String get pleaseAcceptPrivacyPolicy;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @invalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP'**
  String get invalidOtp;

  /// No description provided for @didntGetOtp.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t Get OTP?'**
  String get didntGetOtp;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @otpSentMessageTitle.
  ///
  /// In en, this message translates to:
  /// **'A magic code to sign in was sent to'**
  String get otpSentMessageTitle;

  /// No description provided for @otpResentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'OTP resent successfully.'**
  String get otpResentSuccessfully;

  /// No description provided for @pleaseUploadAllRequiredDocuments.
  ///
  /// In en, this message translates to:
  /// **'Please upload all required documents.'**
  String get pleaseUploadAllRequiredDocuments;

  /// No description provided for @divers.
  ///
  /// In en, this message translates to:
  /// **'Divers'**
  String get divers;

  /// No description provided for @addAccident.
  ///
  /// In en, this message translates to:
  /// **'Add Accident'**
  String get addAccident;

  /// No description provided for @selectOwnPlateNumber.
  ///
  /// In en, this message translates to:
  /// **'Select own plate number'**
  String get selectOwnPlateNumber;

  /// No description provided for @textDescription.
  ///
  /// In en, this message translates to:
  /// **'Text Description'**
  String get textDescription;

  /// No description provided for @describeWhatHappened.
  ///
  /// In en, this message translates to:
  /// **'Describe what happened...'**
  String get describeWhatHappened;

  /// No description provided for @uploadUpTo5Images.
  ///
  /// In en, this message translates to:
  /// **'Upload up to 5 Images'**
  String get uploadUpTo5Images;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @clickHereToRecordAccident.
  ///
  /// In en, this message translates to:
  /// **'Click Here to Record Accident'**
  String get clickHereToRecordAccident;

  /// No description provided for @videoSelected.
  ///
  /// In en, this message translates to:
  /// **'Video Selected:'**
  String get videoSelected;

  /// No description provided for @pleaseUploadPhotos.
  ///
  /// In en, this message translates to:
  /// **'Please upload photos'**
  String get pleaseUploadPhotos;

  /// No description provided for @plateNumber.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plateNumber;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @fuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel Type'**
  String get fuelType;

  /// No description provided for @registrationDateFrom.
  ///
  /// In en, this message translates to:
  /// **'Registration date from'**
  String get registrationDateFrom;

  /// No description provided for @hpPs.
  ///
  /// In en, this message translates to:
  /// **'HP/PS'**
  String get hpPs;

  /// No description provided for @mileage.
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get mileage;

  /// No description provided for @tuvDate.
  ///
  /// In en, this message translates to:
  /// **'TÜV Date'**
  String get tuvDate;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @finVin.
  ///
  /// In en, this message translates to:
  /// **'FIN/VIN'**
  String get finVin;

  /// No description provided for @carImage.
  ///
  /// In en, this message translates to:
  /// **'Car Image'**
  String get carImage;

  /// No description provided for @insuranceCompany.
  ///
  /// In en, this message translates to:
  /// **'Insurance Company'**
  String get insuranceCompany;

  /// No description provided for @insuranceEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Insurance Email Address'**
  String get insuranceEmailAddress;

  /// No description provided for @insuranceNumber.
  ///
  /// In en, this message translates to:
  /// **'Insurance Number'**
  String get insuranceNumber;

  /// No description provided for @validFrom.
  ///
  /// In en, this message translates to:
  /// **'Valid From'**
  String get validFrom;

  /// No description provided for @validTo.
  ///
  /// In en, this message translates to:
  /// **'Valid To'**
  String get validTo;

  /// No description provided for @insurancePdf.
  ///
  /// In en, this message translates to:
  /// **'Insurance PDF'**
  String get insurancePdf;

  /// No description provided for @tuvReportOptional.
  ///
  /// In en, this message translates to:
  /// **'TÜV Report (Optional)'**
  String get tuvReportOptional;

  /// No description provided for @carAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Car added successfully.'**
  String get carAddedSuccessfully;

  /// No description provided for @otherDriver.
  ///
  /// In en, this message translates to:
  /// **'Other Driver'**
  String get otherDriver;

  /// No description provided for @vehiclePlateNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle plate number'**
  String get vehiclePlateNumber;

  /// No description provided for @witness.
  ///
  /// In en, this message translates to:
  /// **'Witness'**
  String get witness;

  /// No description provided for @gettingLocation.
  ///
  /// In en, this message translates to:
  /// **'Getting location…'**
  String get gettingLocation;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Location unavailable'**
  String get locationUnavailable;

  /// No description provided for @turnOnLocationServices.
  ///
  /// In en, this message translates to:
  /// **'Turn on location services to see your address.'**
  String get turnOnLocationServices;

  /// No description provided for @locationPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to show your address.'**
  String get locationPermissionRequired;

  /// No description provided for @unableToLoadLocation.
  ///
  /// In en, this message translates to:
  /// **'Unable to load location.'**
  String get unableToLoadLocation;

  /// No description provided for @searchMyCar.
  ///
  /// In en, this message translates to:
  /// **'Search my car'**
  String get searchMyCar;

  /// No description provided for @chooseYourCar.
  ///
  /// In en, this message translates to:
  /// **'Choose your car'**
  String get chooseYourCar;

  /// No description provided for @paymentSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Payment successful!'**
  String get paymentSuccessful;

  /// No description provided for @paymentFailedTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Payment failed. Please try again.'**
  String get paymentFailedTryAgain;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @paymentWebViewError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get paymentWebViewError;

  /// No description provided for @paymentHttpError.
  ///
  /// In en, this message translates to:
  /// **'HTTP Error'**
  String get paymentHttpError;

  /// No description provided for @isAddressCorrect.
  ///
  /// In en, this message translates to:
  /// **'Is this address correct?'**
  String get isAddressCorrect;

  /// No description provided for @yesCorrect.
  ///
  /// In en, this message translates to:
  /// **'Yes, Correct'**
  String get yesCorrect;

  /// No description provided for @editAddress.
  ///
  /// In en, this message translates to:
  /// **'Edit Address'**
  String get editAddress;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @serviceCharge.
  ///
  /// In en, this message translates to:
  /// **'Service Charge'**
  String get serviceCharge;

  /// No description provided for @vat.
  ///
  /// In en, this message translates to:
  /// **'VAT'**
  String get vat;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @creditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get creditCard;

  /// No description provided for @accidentDetails.
  ///
  /// In en, this message translates to:
  /// **'Accident Details'**
  String get accidentDetails;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current Location'**
  String get currentLocation;

  /// No description provided for @pleaseUploadAtLeastOneCarImage.
  ///
  /// In en, this message translates to:
  /// **'Please upload at least one car image.'**
  String get pleaseUploadAtLeastOneCarImage;

  /// No description provided for @pleaseUploadInsurancePdf.
  ///
  /// In en, this message translates to:
  /// **'Please upload insurance PDF.'**
  String get pleaseUploadInsurancePdf;

  /// No description provided for @pleaseSelectValidFromDateFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select Valid From date first.'**
  String get pleaseSelectValidFromDateFirst;

  /// No description provided for @carImagesUploadLimitReached.
  ///
  /// In en, this message translates to:
  /// **'You can upload up to 5 car images.'**
  String get carImagesUploadLimitReached;

  /// No description provided for @carImagesExtraIgnored.
  ///
  /// In en, this message translates to:
  /// **'Only 5 images are allowed. Extra images were ignored.'**
  String get carImagesExtraIgnored;

  /// No description provided for @dateRangeSeparator.
  ///
  /// In en, this message translates to:
  /// **'—'**
  String get dateRangeSeparator;

  /// No description provided for @drawerMyProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get drawerMyProfile;

  /// No description provided for @caseHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Case History'**
  String get caseHistoryTitle;

  /// No description provided for @drawerEmergencySettings.
  ///
  /// In en, this message translates to:
  /// **'Emergency Settings'**
  String get drawerEmergencySettings;

  /// No description provided for @drawerImprint.
  ///
  /// In en, this message translates to:
  /// **'Imprint'**
  String get drawerImprint;

  /// No description provided for @drawerAgb.
  ///
  /// In en, this message translates to:
  /// **'AGB'**
  String get drawerAgb;

  /// No description provided for @drawerDataSecurity.
  ///
  /// In en, this message translates to:
  /// **'Data Security'**
  String get drawerDataSecurity;

  /// No description provided for @drawerPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get drawerPrivacyPolicy;

  /// No description provided for @drawerLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get drawerLogOut;

  /// No description provided for @logoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// No description provided for @logoutConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmationMessage;

  /// No description provided for @drawerWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get drawerWelcomeBack;

  /// No description provided for @addCarToContinueTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Car to Continue'**
  String get addCarToContinueTitle;

  /// No description provided for @addCarToContinueDescription.
  ///
  /// In en, this message translates to:
  /// **' It looks like you haven\'t added your car yet.\nPlease add your car details to continue\nreporting an accident.'**
  String get addCarToContinueDescription;

  /// No description provided for @caseHistoryCurrentCases.
  ///
  /// In en, this message translates to:
  /// **'Current Cases'**
  String get caseHistoryCurrentCases;

  /// No description provided for @caseHistoryPastCases.
  ///
  /// In en, this message translates to:
  /// **'Past Cases'**
  String get caseHistoryPastCases;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @closed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get closed;

  /// No description provided for @caseHistoryClosureDateLabel.
  ///
  /// In en, this message translates to:
  /// **'CLOSURE DATE'**
  String get caseHistoryClosureDateLabel;

  /// No description provided for @caseHistoryDownloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download Case PDF'**
  String get caseHistoryDownloadPdf;

  /// No description provided for @caseHistoryViewSummary.
  ///
  /// In en, this message translates to:
  /// **'View Summary'**
  String get caseHistoryViewSummary;

  /// No description provided for @caseDetailsSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Case Summary'**
  String get caseDetailsSummaryTitle;

  /// No description provided for @accidentDate.
  ///
  /// In en, this message translates to:
  /// **'Accident Date'**
  String get accidentDate;

  /// No description provided for @caseId.
  ///
  /// In en, this message translates to:
  /// **'Case Id'**
  String get caseId;

  /// No description provided for @caseDetailsRetryPayment.
  ///
  /// In en, this message translates to:
  /// **'Retry Payment'**
  String get caseDetailsRetryPayment;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @caseDetailsRejectedMessage.
  ///
  /// In en, this message translates to:
  /// **'You have rejected this case'**
  String get caseDetailsRejectedMessage;

  /// No description provided for @caseDetailsCloseAccidentCase.
  ///
  /// In en, this message translates to:
  /// **'Close Accident Case'**
  String get caseDetailsCloseAccidentCase;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @caseDetailsEvidenceImages.
  ///
  /// In en, this message translates to:
  /// **'Evidence Images'**
  String get caseDetailsEvidenceImages;

  /// No description provided for @caseDetailsEvidenceVideos.
  ///
  /// In en, this message translates to:
  /// **'Evidence Videos'**
  String get caseDetailsEvidenceVideos;

  /// No description provided for @caseDetailsDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Case Description'**
  String get caseDetailsDescriptionTitle;

  /// No description provided for @caseDetailsNoDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available.'**
  String get caseDetailsNoDescription;

  /// No description provided for @caseDetailsPaymentStatus.
  ///
  /// In en, this message translates to:
  /// **'PAYMENT STATUS'**
  String get caseDetailsPaymentStatus;

  /// No description provided for @caseDetailsCloseCaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Close Case'**
  String get caseDetailsCloseCaseTitle;

  /// No description provided for @caseDetailsCloseCaseConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close this case?'**
  String get caseDetailsCloseCaseConfirmation;

  /// No description provided for @caseDetailsRejectRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject Request'**
  String get caseDetailsRejectRequestTitle;

  /// No description provided for @caseDetailsRejectRequestConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reject this request?'**
  String get caseDetailsRejectRequestConfirmation;

  /// No description provided for @emergencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergencyTitle;

  /// No description provided for @emergencyAddNew.
  ///
  /// In en, this message translates to:
  /// **'Add New'**
  String get emergencyAddNew;

  /// No description provided for @emergencyTrustedFriends.
  ///
  /// In en, this message translates to:
  /// **'Trusted Friends'**
  String get emergencyTrustedFriends;

  /// No description provided for @emergencyActiveBadge.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get emergencyActiveBadge;

  /// No description provided for @emergencySearchHint.
  ///
  /// In en, this message translates to:
  /// **'alex@example.com'**
  String get emergencySearchHint;

  /// No description provided for @confirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you sure'**
  String get confirmTitle;

  /// No description provided for @emergencyAddConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure, you want to add?'**
  String get emergencyAddConfirmationMessage;

  /// No description provided for @emergencyContactAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact added\nsuccessfully'**
  String get emergencyContactAddedSuccess;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
