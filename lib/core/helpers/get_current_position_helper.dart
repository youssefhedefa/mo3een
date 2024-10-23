import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/components/models/current_postion.dart';
import 'package:mo3een/core/utilities/box_constants.dart';

abstract class LocationHelper {
  // static Future<bool> handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are disabled. Please enable the services
  //     return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Location permissions are denied
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // Location permissions are permanently denied, we cannot request permissions.
  //
  //     return false;
  //   }
  //   return true;
  // }

  // static Future<Position> getCurrentPosition() async {
  //   return await Geolocator.getCurrentPosition(
  //     locationSettings: const LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       timeLimit: Duration(seconds: 10),
  //     ),
  //   );
  // }

  static Future<Position> getCurrentPosition() async {
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

  // static Future<String?> getAddressFromPosition(Position position) async {
  //   try{
  //     var box = Hive.box<CurrentPosition>(AppBoxConstants.currentPositionBox);
  //     CurrentPosition currentPosition = box.get(0)!;
  //     DateTime storedDateTime = currentPosition.lastUpdate;
  //     DateTime now = DateTime.now();
  //
  //     log("from cache ${now.difference(storedDateTime).inDays}");
  //
  //     if (box.isNotEmpty && now.difference(storedDateTime).inDays < 3) {
  //       if (currentPosition.latitude == position.latitude &&
  //           currentPosition.longitude == position.longitude) {
  //         log("from cache");
  //         return currentPosition.address;
  //       }
  //     }
  //   }
  //   catch(e){
  //     log(e.toString());
  //   }
  //   try {
  //     await setLocaleIdentifier("ar_EG");
  //     List<Placemark> placeMarks =
  //     await placemarkFromCoordinates(
  //         position.latitude,
  //       position.longitude,
  //     );
  //     Placemark place = placeMarks[0];
  //     String address = "${place.locality}, ${place.administrativeArea}";
  //     cachLastPosition(position,address);
  //     return address;
  //   } catch (e) {
  //     log("getAddressFromLatLng() $e");
  //     return null;
  //   }
  // }

  static cachLastPosition(Position position, String address) async {
    var box = Hive.box<CurrentPosition>(AppBoxConstants.currentPositionBox);
    CurrentPosition currentPosition = CurrentPosition(
      latitude: position.latitude,
      longitude: position.longitude,
      lastUpdate: DateTime.now(),
      address: address,
    );
    await box.add(currentPosition);
  }
}
