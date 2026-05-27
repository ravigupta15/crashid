abstract class ApiUrls {
  ApiUrls._();

  static const baseUrl = "https://apicrid.forthprodigital.in/api/";

  static const loginUrl = '${baseUrl}user/auth/login';
  static const forgotPasswordUrl = '${baseUrl}user/auth/forgot-password';
  static const verifyOtpUrl = "${baseUrl}user/auth/verify-otp";
  static const resendOtpUrl = "${baseUrl}user/auth/resend-otp";
  static const resetPasswordUrl = "${baseUrl}user/auth/reset-password";
  static const personalRegistrationUrl = "${baseUrl}user/auth/register/personal";
  static const companyRegistrationUrl = "${baseUrl}user/auth/register/company";
  static const refreshTokenUrl = "${baseUrl}user/auth/refresh-token";

  // 
  static const profileUrl = "${baseUrl}user/auth/profile";
  static const profileImageUrl = "${baseUrl}user/auth/profile/image";

  //vechile
  static const carBrandsUrl = "${baseUrl}vehicle-masters/brands";
  static const carColorUrl = "${baseUrl}vehicle-masters/colors";
  static const vehicleUrl = "${baseUrl}user/vehicles";

  // notification
  static const fcmTokenUrl = "${baseUrl}user/auth/fcm-token";
  static const notificationUrl = "${baseUrl}notifications";

  // accident
  static const pricingUrl = "${baseUrl}accidents/pricing";
  static const accidentsUrl = "${baseUrl}accidents";

  // search user by email and plate number
  static const searchUserUrl = "${baseUrl}user/auth/search";
  static const emergencyUrl = "${baseUrl}emergency/friends";
  static const sosUrl = "${baseUrl}emergency/sos";

  static const contentUrl = "${baseUrl}content";

  // insurance
  static const insuranceUrl = "${baseUrl}user/vehicles/insurance";

  
}
