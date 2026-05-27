import 'dart:convert';
import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/service/location_service.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/res/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class GoogleMapAddressScreen extends StatefulWidget {
  static const kLat = "/kLat";
  static const kLng = "/kLng";

  final String? lat;
  final String? lng;

  
  static Future<void> open(BuildContext context, {String? lat, String? lng}) {
   return context.push(AppRoutesPath.googleMapScreen, extra: {
      kLat: lat,
      kLng: lng
    });
  }
  const GoogleMapAddressScreen({super.key, this.lat, this.lng});

  @override
  State<GoogleMapAddressScreen> createState() => _GoogleMapAddressScreenState();
}

class _GoogleMapAddressScreenState extends State<GoogleMapAddressScreen> {

  GoogleMapController? _mapController;
  Marker? _marker;
  AppLocationData? selectedAddressModel;
  TextEditingController _searchController = TextEditingController();
  late final LatLng _initialPosition;

  @override
  void initState() {
    super.initState();
    selectedAddressModel = AppLocationData(fullAddress: '', latitude: 0, longitude: 0);
    _initialPosition = _parseLatLng(widget.lat, widget.lng);
    Future.microtask(() {
      _setInitialMarker();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  LatLng _parseLatLng(String? lat, String? lng) {
    final parsedLat = double.tryParse(lat ?? '') ?? 0.0;
    final parsedLng = double.tryParse(lng ?? '') ?? 0.0;
    return LatLng(parsedLat, parsedLng);
  }

  Future<void> _setInitialMarker() async {
    await _updateMarkerAndAddress(_initialPosition);
    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_initialPosition, 15),
    );
  }

  Future<void> _updateMarkerAndAddress(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      print(place);

      final fullAddress = [
        place.street,
        place.subLocality,
        place.locality,
        place.country,
        place.postalCode
      ].where((e) => e != null && e.isNotEmpty).join(", ");

      setState(() {
        _marker = Marker(
          markerId: const MarkerId("draggable_marker"),
          position: position,
          draggable: true,
          onDragEnd: _onMarkerDragged,
          infoWindow: InfoWindow(title: fullAddress),
        );
        selectedAddressModel = AppLocationData(
          fullAddress: fullAddress,
          latitude: position.latitude,
          longitude: position.longitude,
        );
      });
    }
  }

  Future<void> _onSearch(String address) async {
    if (address.trim().isEmpty) return;

    FocusScope.of(context).unfocus();
    String apiKey = AppConstant.googleMapKey;
    final uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      {'address': address, 'key': apiKey},
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK' && (data['results'] as List).isNotEmpty) {
        final result = data['results'][0];
        final lat = result['geometry']['location']['lat'];
        final lng = result['geometry']['location']['lng'];

        final latLng = LatLng(lat, lng);
        await _updateMarkerAndAddress(latLng);
        _mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
      }
    }
  }

  void _onMarkerDragged(LatLng newPosition) {
    _updateMarkerAndAddress(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Map",
         actions: [
          if (_marker != null)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: _btn(
                title: "Done",
                onTap: () {
                  Navigator.pop(context, selectedAddressModel);
                },
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              ),
            ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Enter Address",
                      hintStyle: const TextStyle(fontSize: 13),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                _btn(
                  title: "Search",
                  onTap: () {
                    _onSearch(_searchController.text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 15,
              ),
              markers: _marker != null ? {_marker!} : {},
              onMapCreated: (controller) {
                _mapController = controller;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(
      {required String title,
      required VoidCallback onTap,
      EdgeInsets? padding}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(title, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

