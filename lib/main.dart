import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mo3een/core/managers/di.dart';
import 'package:mo3een/core/utilities/bloc_observer.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/home/data/models/home_data_model.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';
import 'package:mo3een/features/home/data/services/notification_service.dart';
import 'package:mo3een/features/quran/data/models/quran_mark_model.dart';
import 'package:mo3een/features/sep7a/data/models/sep7a_model.dart';
import 'package:mo3een/mo3een_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  changeSystemUiOverlayStyle();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  await ScreenUtil.ensureScreenSize();
  await EasyLocalization.ensureInitialized();
  await setupDependencyInjection();
  await getIt<NotificationServiceContract>().initNotification();
  Hive.registerAdapter(QuranMarkModelAdapter());
  Hive.registerAdapter(AzkarModelAdapter());
  Hive.registerAdapter(ZekrItemAdapter());
  Hive.registerAdapter(Sep7aZekrModelAdapter());
  Hive.registerAdapter(PrayerModelAdapter());
  Hive.registerAdapter(HomeDataModelAdapter());
  await Future.wait([
    Hive.openBox<QuranMarkModel>(AppBoxConstants.quranMarksBox),
    Hive.openBox<AzkarModel>(AppBoxConstants.azkarBox),
    Hive.openBox<ZekrItem>(AppBoxConstants.zekrItemBox),
    Hive.openBox<Sep7aZekrModel>(AppBoxConstants.sep7aZekrBox),
    Hive.openBox<PrayerModel>(AppBoxConstants.prayersBox),
    Hive.openBox<HomeDataModel>(AppBoxConstants.homeDataBox),
    Hive.openBox(AppBoxConstants.onBoardingBox),
    Hive.openBox(AppBoxConstants.notificationSettingsBox),
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar')],
      path: AppConstants.translationPath,
      fallbackLocale: const Locale('ar'),
      child: const Mo3eenApp(),
    ),
  );
}

changeSystemUiOverlayStyle() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );
}
