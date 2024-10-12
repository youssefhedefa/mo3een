class QuranPageModel {
  final int pageNumber;
  final String? ayahText;
  final int? ayahNumber;
  final int? suraNumber;

  QuranPageModel({
    required this.pageNumber,
    this.ayahText,
    this.ayahNumber,
    this.suraNumber,
  });
}
