import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/components/models/current_postion.dart';
import 'package:mo3een/core/helpers/connectivity_helper.dart';
import 'package:mo3een/core/helpers/get_current_position_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/permission_helper.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/home/data/data_source/api/home_api_services.dart';
import 'package:mo3een/features/home/data/data_source/cached/get_cached_current_postion.dart';
import 'package:mo3een/features/home/data/data_source/cached/get_cached_prayers_time.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';

class HomeRepo {
  final HomeApiServices service;

  HomeRepo({required this.service});

  Future<CurrentPosition> getCachedPosition() async {
    return CachedPosition.getCachePosition();
  }

  Future<CurrentPosition> getCurrentPosition() async {
    if (await AppPermissionHelper.checkLocationPermission()) {
      CurrentPosition cachedPosition = await getCachedPosition();
      bool isConnected = await ConnectivityHelper.isConnected();
      if (isConnected &&
          cachedPosition.lastUpdate.difference(DateTime.now()).inDays.abs() >=
              3) {
        final position = await LocationHelper.getCurrentPosition();
        final now = DateTime.now();
        CurrentPosition currentPosition = CurrentPosition(
          address: await getCurrentLocation(
            long: position.longitude,
            lat: position.latitude,
          ),
          latitude: position.latitude,
          longitude: position.longitude,
          lastUpdate: now,
        );
        CachedPosition.setCachePosition(currentPosition);
        return currentPosition;
      }
      return cachedPosition;
    }
    return AppConstants.cachedPosition;
  }

  Future<String> getCurrentLocation(
      {required num long, required num lat}) async {
    if (await AppPermissionHelper.checkLocationPermission()) {
      CurrentPosition cachedPosition = await getCachedPosition();
      bool isConnected = await ConnectivityHelper.isConnected();
      if (isConnected &&
          cachedPosition.lastUpdate.difference(DateTime.now()).inDays.abs() >=
              3) {
        final now = DateTime.now();
        final address = await LocationHelper.getAddressFromLanLat(
            longitude: long, latitude: lat);
        CurrentPosition currentPosition = CurrentPosition(
          address: address,
          latitude: lat.toDouble(),
          longitude: long.toDouble(),
          lastUpdate: now,
        );
        CachedPosition.setCachePosition(currentPosition);
        return currentPosition.address;
      }
      return cachedPosition.address;
    }
    return 'القاهره, مصر';
  }
  bool getPrayersTimesFlag = true;
  Future<Either<List<PrayerModel>, String>> getPrayerTimes(
      {required num latitude, required num longitude}) async {
    if (await AppPermissionHelper.checkLocationPermission()) {
      CurrentPosition cachedPosition = await getCachedPosition();
      bool isConnected = await ConnectivityHelper.isConnected();
      log('have permission $isConnected + ${cachedPosition.lastUpdate.difference(DateTime.now()).inDays.abs()}');
      if (isConnected && getPrayersTimesFlag) {
        log('get from api');
        getPrayersTimesFlag = false;
        return _fetchPrayTimesFromApi(latitude: latitude, longitude: longitude);
      } else {
        log('get from cache');
        return _fetchPrayTimesFromCache();
      }
    }
    log('no permission');
    return Left(_getNearestPrayer(AppConstants.testPrayersList));
  }

  Future<Either<List<PrayerModel>, String>> _fetchPrayTimesFromApi(
      {required num latitude, required num longitude}) async {
    final response =
        await service.getPrayerTimes(latitude: latitude, longitude: longitude);
    if (response.data is String) {
      return Right(response.data.toString());
    }
    List<PrayerModel> prayers = [
      PrayerModel(
        icon: AppIconHelper.elFajrIcon,
        prayer: 'الفجر',
        time: response.data.timings!.fajr!,
        hisTurn: false,
      ),
      PrayerModel(
        icon: AppIconHelper.el4rokIcon,
        prayer: 'الشروق',
        time: response.data.timings!.sunrise!,
        hisTurn: false,
      ),
      PrayerModel(
        icon: AppIconHelper.elZohrIcon,
        prayer: 'الظهر',
        time: response.data.timings!.dhuhr!,
        hisTurn: false,
      ),
      PrayerModel(
        icon: AppIconHelper.el3asrIcon,
        prayer: 'العصر',
        time: response.data.timings!.asr!,
        hisTurn: false,
      ),
      PrayerModel(
        icon: AppIconHelper.elMa8rebIcon,
        prayer: 'المغرب',
        time: response.data.timings!.maghrib!,
        hisTurn: false,
      ),
      PrayerModel(
        icon: AppIconHelper.el3e4a2Icon,
        prayer: 'العشاء',
        time: response.data.timings!.isha!,
        hisTurn: false,
      ),
    ];
    await _cachPrayerTimes(prayers);
    return Left(_getNearestPrayer(prayers));
  }

  _cachPrayerTimes(List<PrayerModel> prayers) async{
    var box = Hive.box<PrayerModel>(AppBoxConstants.prayersBox);
    await box.clear();
    await box.addAll(prayers);
  }

  List<PrayerModel> _getNearestPrayer(List<PrayerModel> prayers) {
    PrayerModel nearestPrayer = _getNextPrayer(prayers) ?? prayers.first;
    prayers[prayers
            .indexWhere((element) => element.prayer == nearestPrayer.prayer)]
        .hisTurn = true;
    return prayers;
  }

  PrayerModel? _getNextPrayer(List<PrayerModel> prayers) {
    final now = DateTime.now();
    for (var prayer in prayers) {
      final prayerTime = _parseTime(prayer.time);
      if (now.hour < prayerTime.hour ||
          (now.hour == prayerTime.hour && now.minute < prayerTime.minute)) {
        return prayer;
      }
    }
    return null;
  }

  DateTime _parseTime(String time) {
    log('time: $time');
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
  Future<Either<List<PrayerModel>, String>> _fetchPrayTimesFromCache() {
    return GetCachedPrayerTimes.getPrayerTimes().then(
      (value) => Left(_getNearestPrayer(value)),
    );
  }
}
