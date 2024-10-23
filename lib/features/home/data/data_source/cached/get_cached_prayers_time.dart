import 'package:hive/hive.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';

class GetCachedPrayerTimes{

  GetCachedPrayerTimes();

  static Future<List<PrayerModel>> getPrayerTimes() async {
    var box = Hive.box<PrayerModel>(AppBoxConstants.prayersBox);
    List<PrayerModel> prayers = box.values.toList();
    if(prayers.isEmpty){
      return AppConstants.testPrayersList;
    }
    return prayers;
  }
}