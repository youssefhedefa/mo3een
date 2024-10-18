import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationHelper {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled. Please enable the services
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied, we cannot request permissions.

      return false;
    }
    return true;
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) return null;
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } catch (e) {
      log("getCurrentPosition() $e");
      return null;
    }
  }

  static Future<String?> getAddressFromLatLng(Position position) async {
    try {
      await setLocaleIdentifier("ar_EG");
      List<Placemark> placeMarks =
      await placemarkFromCoordinates(
          position.latitude,
        position.longitude,
      );
      Placemark place = placeMarks[0];
      return "${place.locality}, ${place.administrativeArea}";
    } catch (e) {
      log("getAddressFromLatLng() $e");
      return null;
    }
  }
}