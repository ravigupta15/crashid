import 'package:crashid/app_routes/app_routes.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class AppLocationData {
  final String fullAddress;
  final double latitude;
  final double longitude;
  final String? city;
  final String? street;
  final String? houseNumber;
  final String? postalCode;

  const AppLocationData({
    required this.fullAddress,
    required this.latitude,
    required this.longitude,
    this.city,
    this.street,
    this.houseNumber,
    this.postalCode,
  });
}

/// Pure service to fetch location (lat/lng) and resolve it to a full address.
///
/// No UI is created here; call it from any screen/widget.
class LocationService {
  LocationService._();

  static final LocationService instance = LocationService._();

  static LocationService get shared => instance;

  AppLocationData? _cachedLocation;
  Future<AppLocationData>? _currentLocationFuture;

  AppLocationData? get cachedLocation => _cachedLocation;

  /// Returns the current GPS position + reverse-geocoded full address.
  ///
  /// The first call fetches the value from the device. Subsequent calls
  /// return the cached location so the address is only resolved once.
  Future<AppLocationData> _getCurrentLocationWithAddress() async {
    if (_cachedLocation != null) {
      return _cachedLocation!;
    }

    if (_currentLocationFuture != null) {
      return _currentLocationFuture!;
    }

    _currentLocationFuture = _loadCurrentLocation();
    try {
      return await _currentLocationFuture!;
    } finally {
      _currentLocationFuture = null;
    }
  }

  static Future<AppLocationData> getCurrentLocationWithAddress() {
    return instance._getCurrentLocationWithAddress();
  }

  static AppLocationData? getCurrentCachedLocation() {
    return instance.cachedLocation;
  }

  static void clearCurrentLocationCache() {
    instance._cachedLocation = null;
  }

  Future<AppLocationData> _loadCurrentLocation() async {
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
    final placemark = placemarks.isNotEmpty ? placemarks.first : null;

    final location = AppLocationData(
      fullAddress: fullAddress,
      latitude: position.latitude,
      longitude: position.longitude,
      city: placemark?.locality,
      street: placemark?.thoroughfare ?? placemark?.street,
      houseNumber: placemark?.subThoroughfare,
      postalCode: placemark?.postalCode,
    );

    print('LocationService: loaded location -> '
      'fullAddress=${location.fullAddress}, '
      'latitude=${location.latitude}, '
      'longitude=${location.longitude}, '
      'city=${location.city}, '
      'street=${location.street}, '
      'houseNumber=${location.houseNumber}, '
      'postalCode=${location.postalCode}');

    _cachedLocation = location;
    return location;
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
    final placemark = placemarks.isNotEmpty ? placemarks.first : null;

    return AppLocationData(
      fullAddress: fullAddress,
      latitude: first.latitude,
      longitude: first.longitude,
      city: placemark?.locality,
      street: placemark?.thoroughfare ?? placemark?.street,
      houseNumber: placemark?.subThoroughfare,
      postalCode: placemark?.postalCode,
    );
  }

  static String _formatPlacemark(List<Placemark> placemarks) {
    if (placemarks.isEmpty) return AppLocalizations.of(AppRouter.mainNavigatorKey.currentContext!)!.unknownAddress; 
    final p = placemarks.first;

    final parts = <String?>[
      // p.name,
      p.street,
      p.locality,
      // p.subAdministrativeArea,
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

