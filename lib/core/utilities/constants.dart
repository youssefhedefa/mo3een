import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';

abstract class AppConstants{
  static const String translationPath = 'assets/translations';
  static const String fontFamilyName = 'Almarai';
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
}