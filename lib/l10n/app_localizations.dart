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
