import 'dart:developer';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/components/models/current_postion.dart';
import 'package:mo3een/core/utilities/box_constants.dart';

abstract class LocationHelper {

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
