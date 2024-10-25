import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mo3een/core/helpers/connectivity_helper.dart';
import 'package:mo3een/core/helpers/get_current_position_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/features/home/data/data_source/api/home_api_services.dart';
import 'package:mo3een/features/home/data/data_source/cached/cached_home_data.dart';
import 'package:mo3een/features/home/data/models/home_data_model.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';

class HomeRepo {
  HomeRepo({required this.service});
  final HomeApiServices service;

  bool getPrayersTimesFlag = true;
  Future<Either<String, HomeDataModel>> getHomeData({required bool refresh}) async {
    bool isConnected = await ConnectivityHelper.isConnected();
    log('Connection is $isConnected');
    if (isConnected && (refresh || getPrayersTimesFlag)) {
      return _getHomeDataFromNetwork();
    } else {
      return _getHomeDataFromCache();
    }
  }

  Future<Either<String, HomeDataModel>> _getHomeDataFromNetwork() async {
    try {
      CachedHomeData cachedHomeData = CachedHomeData();
      Position position = await LocationHelper.getCurrentPosition();
      String location = await LocationHelper.getAddressFromLanLat(
          longitude: position.longitude, latitude: position.latitude);
      final response = await service.getPrayerTimes(
          latitude: position.latitude, longitude: position.longitude);
      if (response.data is String) {
        return Left(response.data.toString());
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
      PrayerModel nearestPrayer = _getNearestPrayer(prayers)
          .firstWhere((element) => element.hisTurn == true);
      HomeDataModel homeData = HomeDataModel(
        location: location,
        nextPrayer: nearestPrayer.prayer,
        nextPrayerTimeHoursLeft: _getRemainingTime(nearestPrayer).inHours,
        nextPrayerTimeMinutesLeft:
            _getRemainingTime(nearestPrayer).inMinutes % 60,
        prayers: _getNearestPrayer(prayers),
      );
      cachedHomeData.cacheHomeData(homeData: homeData);
      getPrayersTimesFlag = false;
      return Right(homeData);
    } catch (e) {
      log('error here ${e.toString()}');
      getPrayersTimesFlag = true;
      return Left(e.toString());
    }
  }

  Future<Either<String, HomeDataModel>> _getHomeDataFromCache() async {
    try {
      HomeDataModel cachedHomeData = await CachedHomeData().getHomeData();
      PrayerModel nearestPrayer = _getNearestPrayer(cachedHomeData.prayers!)
          .firstWhere((element) => element.hisTurn == true);
      HomeDataModel homeData = HomeDataModel(
        location: cachedHomeData.location,
        nextPrayer: nearestPrayer.prayer,
        nextPrayerTimeHoursLeft: _getRemainingTime(nearestPrayer).inHours,
        nextPrayerTimeMinutesLeft:
        _getRemainingTime(nearestPrayer).inMinutes % 60,
        prayers: _getNearestPrayer(cachedHomeData.prayers!),
      );
      return Right(homeData);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Duration _getRemainingTime(PrayerModel pray) {
    DateTime now = DateTime.now();
    DateTime prayerTime = _parseTime(pray.time);
    if (prayerTime.isBefore(now)) {
      prayerTime = prayerTime.add(const Duration(days: 1));
    }
    Duration remainingTime = prayerTime.difference(now);
    return remainingTime;
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
}
