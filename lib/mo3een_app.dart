import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mo3een/core/managers/di.dart';
import 'package:mo3een/features/more/data/services/salah_reminder_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/helpers/theme_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/core/routing/routing_manager.dart';
import 'package:mo3een/core/utilities/box_constants.dart';

class Mo3eenApp extends StatefulWidget {
  const Mo3eenApp({super.key});

  @override
  State<Mo3eenApp> createState() => _Mo3eenAppState();
}

class _Mo3eenAppState extends State<Mo3eenApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(getIt<SalahReminderManager>().reconcile());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Mo3een',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: AppThemeHelper.appTheme,
          onGenerateRoute: AppRoutingManager().onGenerateRoute,
          initialRoute: checkStartingPoint(),
        );
      },
    );
  }

  String checkStartingPoint() {
    final box = Hive.box(AppBoxConstants.onBoardingBox);
    if (box.get(0) == null) {
      return AppRoutingConstances.onBourding;
    }
    return AppRoutingConstances.home;
  }
}
