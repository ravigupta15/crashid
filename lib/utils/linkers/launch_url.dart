import 'dart:io';
import 'package:crashid/utils/feedback/feedback_message.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LaunchURLUtils {
  
void launchMap({
    required double? latitude,
    required double? longitude,
  }) async {
   final String query = '${latitude ?? 0.0},${longitude  ?? 0.0}';

  // Android: Google Maps app
  final Uri androidGoogleMapsAppUri = Uri.parse('geo:$query?q=$query');

  // iOS: Apple Maps
  final Uri iosAppleMapsUri = Uri.parse('http://maps.apple.com/?ll=$query');

  // Web fallback
  final Uri webUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');

  try {
    if (Platform.isAndroid) {
      // Try opening in Google Maps app using geo URI
      if (await canLaunchUrl(androidGoogleMapsAppUri)) {
        await launchUrl(androidGoogleMapsAppUri, mode: LaunchMode.externalApplication);
        return;
      }
    } else if (Platform.isIOS) {
      // Try opening in Apple Maps
      if (await canLaunchUrl(iosAppleMapsUri)) {
        await launchUrl(iosAppleMapsUri, mode: LaunchMode.externalApplication);
        return;
      }
    }

    // Fallback: open in browser
    if (await canLaunchUrl(webUri)) {
      await launchUrl(webUri, mode: LaunchMode.externalApplication);
    } else {
      showFeedbackMessage("Could not open map.");
    }
  } catch (e) {
    showFeedbackMessage("An error occurred: $e");
  }
  }
  // void launchMap({
  //   required double startLatitude,
  //   required double startLongitude,
  //   required double endLatitude,
  //   required double endLongitude,
  // }) async {
  //   // Universal map URL (works for both iOS and Android)
  //   final Uri appleMapsUri = Uri.parse(
  //       'maps://?saddr=$startLatitude,$startLongitude&daddr=$endLatitude,$endLongitude');
  //   // Fallback to web maps if geo URL is not supported
  //   final Uri googleMapsUri = Uri.parse(
  //       'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$endLatitude,$endLongitude&travelmode=driving');

  //   if (await canLaunchUrl(appleMapsUri)) {
  //     // Launch native map app (Google Maps/Apple Maps/other)
  //     await launchUrl(appleMapsUri);
  //   } else if (await canLaunchUrl(googleMapsUri)) {
  //     // Fallback to web-based map
  //     await launchUrl(googleMapsUri);
  //   } else {
  //     showFeedbackMessage("Something went wrong");
  //   }
  // }

  Future<void> launchURL(Uri url,
      {LaunchMode mode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showFeedbackMessage("Something went wrong");
    }
  }

  Future<void> launchStringURL(String url,
      {LaunchMode mode = LaunchMode.platformDefault}) async {
    Uri uri = Uri.parse(url);
    launchURL(uri, mode: mode);
  }
}
