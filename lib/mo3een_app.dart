import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/theme_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/core/routing/routing_manager.dart';

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
            initialRoute: AppRoutingConstances.home,
          );
        },
    );
  }
}
