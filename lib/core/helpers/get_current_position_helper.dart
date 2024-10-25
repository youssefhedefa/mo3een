import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class LocationHelper {

  static Future<void> checkLocationPermission() async {
    log('check point');
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log('serviceEnabled $serviceEnabled');
    // Always request permission, even if location services are enabled
    LocationPermission permission = await Geolocator.checkPermission();
    log('permission $permission');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if ([LocationPermission.denied, LocationPermission.unableToDetermine, LocationPermission.deniedForever].contains(permission)) {
        // Permissions are denied, you can show a message to the user.
        await Geolocator.openAppSettings();
        // print('Location permissions are denied.');
        return;
      }
    }
  }

  static Future<Position> getCurrentPosition() async {
    await checkLocationPermission();
    final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    return await Isolate.run<Position>(
      () async {
        BackgroundIsolateBinaryMessenger.ensureInitialized(
            rootIsolateToken
        );
        return await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 10),
          ),
        );
      },
    );
  }

  static Future<String> getAddressFromLanLat(
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
