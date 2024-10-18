import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/components/models/current_postion.dart';
import 'package:mo3een/core/helpers/connectivity_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/home/data/data_source/api/home_api_services.dart';
import 'package:mo3een/features/home/data/data_source/cached/get_cached_prayers_time.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';

class HomeRepo {
  final HomeApiServices service;

  HomeRepo({required this.service});

  Future<Either<List<PrayerModel>, String>> getPrayerTimes(
      {required num latitude, required num longitude}) async {
    bool isConnected = await ConnectivityHelper.isConnected();
    var box = Hive.box<CurrentPosition>(AppBoxConstants.currentPositionBox);
    CurrentPosition currentPosition = box.get(0)!;
    DateTime storedDateTime = currentPosition.lastUpdate;
    DateTime now = DateTime.now();
    if (isConnected && (box.isEmpty || now.difference(storedDateTime).inDays >= 3)) {
      return fetchFromApi(latitude: latitude, longitude: longitude);
    }
    return fetchFromCache().then((value) => Left(getNearestPrayer(value)));
  }

  Future<Either<List<PrayerModel>, String>> fetchFromApi(
      {required num latitude, required num longitude,}) async {
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
    cachePrayerTimes(prayers);
    return Left(getNearestPrayer(prayers));
  }

  List<PrayerModel> getNearestPrayer(List<PrayerModel> prayers) {
    PrayerModel nearestPrayer = getNextPrayer(prayers) ?? prayers.first;
    prayers[prayers
        .indexWhere((element) => element.prayer == nearestPrayer.prayer)]
        .hisTurn = true;
    return prayers;
  }

  Future<List<PrayerModel>> fetchFromCache() async {
    List<PrayerModel> prayers = await GetCachedPrayerTimes.getPrayerTimes();
    return prayers;
  }

  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final parts = time.split(':');
    return DateTime(
        now.year, now.month, now.day, int.parse(parts[0]), int.parse(parts[1]));
  }

  PrayerModel? getNextPrayer(List<PrayerModel> prayers) {
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

  cachePrayerTimes(List<PrayerModel> prayers) async {
    var box = Hive.box<PrayerModel>(AppBoxConstants.prayersBox);
    await box.clear();
    await box.addAll(prayers);
  }
}
