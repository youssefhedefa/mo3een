import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/home/presentation/home.dart';

class Mo3eenApp extends StatelessWidget {
  const Mo3eenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mo3een',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: AppColorHelper.primaryColor),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColorHelper.whiteColor,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: AppColorHelper.whiteColor,
        ),
      ).copyWith(
        textTheme: ThemeData().textTheme.apply(
              fontFamily: AppConstants.fontFamilyName,
            ),
      ),
      home: const AppHome(),
    );
  }
}
