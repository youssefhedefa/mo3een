
import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';

class Surah {
  int id;
  String revelationPlace;
  int revelationOrder;
  String name;
  String arabicName;
  int versesCount;
  Surah({
    required this.arabicName,
    required this.id,
    required this.name,
    required this.revelationOrder,
    required this.revelationPlace,
    required this.versesCount,
  });
  factory Surah.fromMap(Map<String, dynamic> json) => Surah(
    arabicName: json["name_arabic"],
    id: json["id"],
    name: json["name_simple"],
    revelationOrder: json["revelation_order"],
    revelationPlace: json["revelation_place"],
    versesCount: json["verses_count"],
  );

  static List<SuraEntity> createSuraEntities(List<dynamic> surahsData) {
    return surahsData.map((surahData) => SuraEntity(
      number: surahData['number'],
      name: surahData['name'],
      ayahsNumber: surahData['numberOfAyahs'],
      revelationType: surahData['revelationTypeInArabic'],
    )).toList();
  }

}