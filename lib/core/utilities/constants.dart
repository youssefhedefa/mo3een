import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';

abstract class AppConstants{
  static const String translationPath = 'assets/translations';
  static const String appFontFamilyName = 'Almarai';
  static const String quranFontFamilyName = 'AmiriQuran';
  static List<PrayerModel> testPrayersList = [
    PrayerModel(
      icon: AppIconHelper.elFajrIcon,
      prayer: 'الفجر',
      time: '4:30 ص',
      hisTurn: false,
    ),
    PrayerModel(
      icon: AppIconHelper.el4rokIcon,
      prayer: 'الشروق',
      time: '5:45 ص',
      hisTurn: false,
    ),
    PrayerModel(
      icon: AppIconHelper.elZohrIcon,
      prayer: 'الظهر',
      time: '12:30 م',
      hisTurn: false,
    ),
    PrayerModel(
      icon: AppIconHelper.el3asrIcon,
      prayer: 'العصر',
      time: '3:45 م',
      hisTurn: true,
    ),
    PrayerModel(
      icon: AppIconHelper.elMa8rebIcon,
      prayer: 'المغرب',
      time: '6:30 م',
      hisTurn: false,
    ),
    PrayerModel(
      icon: AppIconHelper.el3e4a2Icon,
      prayer: 'العشاء',
      time: '8:00 م',
      hisTurn: false,
    ),
  ];
  static List<String> juzNumbers = [
    'الجزء الاول',
    'الجزء الثاني',
    'الجزء الثالث',
    'الجزء الرابع',
    'الجزء الخامس',
    'الجزء السادس',
    'الجزء السابع',
    'الجزء الثامن',
    'الجزء التاسع',
    'الجزء العاشر',
    'الجزء الحادي عشر',
    'الجزء الثاني عشر',
    'الجزء الثالث عشر',
    'الجزء الرابع عشر',
    'الجزء الخامس عشر',
    'الجزء السادس عشر',
    'الجزء السابع عشر',
    'الجزء الثامن عشر',
    'الجزء التاسع عشر',
    'الجزء العشرون',
    'الجزء الحادي والعشرون',
    'الجزء الثاني والعشرون',
    'الجزء الثالث والعشرون',
    'الجزء الرابع والعشرون',
    'الجزء الخامس والعشرون',
    'الجزء السادس والعشرون',
    'الجزء السابع والعشرون',
    'الجزء الثامن والعشرون',
    'الجزء التاسع والعشرون',
    'الجزء الثلاثون',
  ];
}