import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log('serviceEnabled $serviceEnabled');
    LocationPermission permission = await Geolocator.checkPermission();
    log('permission $permission');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if ([
        LocationPermission.denied,
        LocationPermission.unableToDetermine,
        LocationPermission.deniedForever,
      ].contains(permission)) {
        await Geolocator.openAppSettings();
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }
    }
    log('permission 2 $permission');
    return true;
  }

  Future<Position> getCurrentPosition() async {
    log('getCurrentPosition called');
    await checkLocationPermission();
    log('checkLocationPermission done');
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 30),
      ),
    );
  }

  Future<String> getAddressFromLanLat({
    required num longitude,
    required num latitude,
  }) async {
    try {
      final geocoding = Geocoding(locale: const Locale('ar', 'EG'));
      List<Placemark> placeMarks = await geocoding.placemarkFromCoordinates(
        latitude.toDouble(),
        longitude.toDouble(),
        locale: const Locale('ar', 'EG'),
      );
      Placemark place = placeMarks[0];
      return "${place.administrativeArea}, ${place.country}";
    } catch (e) {
      return "القاهره, مصر";
    }
  }

  Future<String> getLocal() async {
    try {
      final String currentTimeZone =
          (await FlutterTimezone.getLocalTimezone()).identifier;
      return currentTimeZone;
    } catch (e) {
      log("getLocal() $e");
      return "Africa/Cairo";
    }
  }
}
