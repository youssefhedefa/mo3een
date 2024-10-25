import 'package:hive/hive.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/home/data/models/home_data_model.dart';

class CachedHomeData {
  CachedHomeData();

  Future<HomeDataModel> getHomeData() async {
    final box = Hive.box<HomeDataModel>(AppBoxConstants.homeDataBox);
    if (box.isEmpty) {
      return HomeDataModel(
        location: 'غير متوفر',
        nextPrayer: 'غير متوفر',
        prayers: AppConstants.testPrayersList,
        nextPrayerTimeHoursLeft: 0,
        nextPrayerTimeMinutesLeft: 0,
      );
    }
    return box.getAt(0)!;
  }

  Future cacheHomeData({required HomeDataModel homeData}) async {
    final box = Hive.box<HomeDataModel>(AppBoxConstants.homeDataBox);
    await box.clear();
    await box.add(homeData);
  }
}
