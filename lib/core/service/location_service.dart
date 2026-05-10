import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AppLocationData {
  final String fullAddress;
  final double latitude;
  final double longitude;

  const AppLocationData({
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
  });
}

/// Pure service to fetch location (lat/lng) and resolve it to a full address.
///
/// No UI is created here; call it from any screen/widget.
class LocationService {
  /// Returns the current GPS position + reverse-geocoded full address.
  static Future<AppLocationData> getCurrentLocationWithAddress() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.always &&
        permission != LocationPermission.whileInUse) {
      throw Exception('Location permission denied.');
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final fullAddress = _formatPlacemark(placemarks);

    return AppLocationData(
      fullAddress: fullAddress,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  /// Converts a full address text to lat/lng and also returns a cleaned address.
  static Future<AppLocationData> getLatLngFromAddress(String address) async {
    final rawAddress = address.trim();
    if (rawAddress.isEmpty) {
      throw Exception('Address is empty.');
    }

    final locations = await locationFromAddress(rawAddress);
    if (locations.isEmpty) {
      throw Exception('No results found for this address.');
    }

    final first = locations.first;

    final placemarks = await placemarkFromCoordinates(
      first.latitude,
      first.longitude,
    );
    final fullAddress = _formatPlacemark(placemarks);

    return AppLocationData(
      fullAddress: fullAddress,
      latitude: first.latitude,
      longitude: first.longitude,
    );
  }

  static String _formatPlacemark(List<Placemark> placemarks) {
    if (placemarks.isEmpty) return 'Unknown address';
    final p = placemarks.first;

    final parts = <String?>[
      p.name,
      p.street,
      p.locality,
      p.subAdministrativeArea,
      p.administrativeArea,
      p.postalCode,
      p.country,
    ]
        .where((e) => e != null && e.toString().trim().isNotEmpty)
        .map((e) => e!.toString().trim())
        .toList();

    return parts.join(', ');
  }
}

