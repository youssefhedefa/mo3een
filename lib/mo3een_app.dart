import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/helpers/theme_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/core/routing/routing_manager.dart';
import 'package:mo3een/core/utilities/box_constants.dart';

class Mo3eenApp extends StatelessWidget {
  const Mo3eenApp({super.key});

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
    log('box.get(0) ${box.get(0)}');
    if(box.get(0) == null){
      return AppRoutingConstances.onBourding;
    }
    return AppRoutingConstances.home;
  }
}