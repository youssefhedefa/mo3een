import 'package:hive/hive.dart';
part 'prayer_model.g.dart';

@HiveType(typeId: 4)
class PrayerModel extends HiveObject{
  @HiveField(0)
  final String prayer;
  @HiveField(1)
  final String time;
  @HiveField(2)
  final String icon;
  @HiveField(3)
  bool hisTurn;

  PrayerModel({
    required this.prayer,
    required this.time,
    required this.icon,
    required this.hisTurn,
  });

}
