import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  int counter = 0;
  Future<bool> checkLocationPermission() async {
    counter++;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log('serviceEnabled $serviceEnabled');
    LocationPermission permission = await Geolocator.checkPermission();
    log('permission $permission');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if ([
        LocationPermission.denied,
        LocationPermission.unableToDetermine,
        LocationPermission.deniedForever
      ].contains(permission)) {
        await Geolocator.openAppSettings();
        permission = await Geolocator.requestPermission();
        if (counter > 2) {
          return false;
        }
        return await checkLocationPermission();
      }
    }
    return true;
  }

  Future<Position> getCurrentPosition() async {
    await checkLocationPermission();
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      ),
    );
  }

  Future<String> getAddressFromLanLat(
      {required num longitude, required num latitude}) async {
    try {
      await setLocaleIdentifier("ar_EG");
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        latitude.toDouble(),
        longitude.toDouble(),
      );
      Placemark place = placeMarks[0];
      return "${place.administrativeArea}, ${place.country}";
    } catch (e) {
      log("getAddressFromLanLat() $e");
      return "القاهره, مصر";
    }
  }
}
