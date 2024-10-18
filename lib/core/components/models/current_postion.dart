import 'package:hive/hive.dart';
part 'current_postion.g.dart';

@HiveType(typeId: 5)
class CurrentPosition extends HiveObject{
  @HiveField(0)
  final double latitude;
  @HiveField(1)
  final double longitude;
  @HiveField(2)
  final DateTime lastUpdate;
  @HiveField(3)
  final String address;

  CurrentPosition({required this.latitude, required this.longitude, required this.lastUpdate, required this.address});
}