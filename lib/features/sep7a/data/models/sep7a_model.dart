import 'package:hive/hive.dart';
part 'sep7a_model.g.dart';

@HiveType(typeId: 3)
class Sep7aZekrModel extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int count;

  Sep7aZekrModel({required this.id, required this.title, required this.count});
}