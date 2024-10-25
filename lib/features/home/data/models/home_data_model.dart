
import 'package:hive/hive.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';
part 'home_data_model.g.dart';

@HiveType(typeId: 10)
class HomeDataModel extends HiveObject {
  @HiveField(0)
  final String? location;
  @HiveField(1)
  final String? nextPrayer;
  @HiveField(2)
  final int? nextPrayerTimeHoursLeft;
  @HiveField(3)
  final int? nextPrayerTimeMinutesLeft;
  @HiveField(4)
  final List<PrayerModel>? prayers;

  HomeDataModel({
    required this.location,
    required this.nextPrayer,
    required this.prayers,
    required this.nextPrayerTimeHoursLeft,
    required this.nextPrayerTimeMinutesLeft,
  });
}
