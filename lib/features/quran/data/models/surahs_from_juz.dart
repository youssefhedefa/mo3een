class SurahsFromJuzModel {
  int surahNumber;
  List<int> verses;

  SurahsFromJuzModel({required this.surahNumber, required this.verses});

  factory SurahsFromJuzModel.fromMap(Map<int, List<int>> juz) {
    return SurahsFromJuzModel(
      surahNumber: juz.keys.first,
      verses: juz.values.first,
    );
  }

}
