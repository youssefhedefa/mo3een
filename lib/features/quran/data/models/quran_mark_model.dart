import 'package:hive/hive.dart';
part 'quran_mark_model.g.dart';

@HiveType(typeId: 0)
class QuranMarkModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? surah;

  @HiveField(2)
  int? ayah;

  @HiveField(3)
  int? page;

  @HiveField(4)
  List<int>? marks;

  QuranMarkModel({
    this.id,
    this.surah,
    this.ayah,
    this.marks,
    this.page,
  });
}
