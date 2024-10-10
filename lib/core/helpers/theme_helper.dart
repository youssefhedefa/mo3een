import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/utilities/constants.dart';

abstract class AppThemeHelper{
  static ThemeData appTheme = ThemeData(
    colorScheme:
    ColorScheme.fromSeed(seedColor: AppColorHelper.primaryColor),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColorHelper.whiteColor,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: AppColorHelper.whiteColor,
    ),
  ).copyWith(
    textTheme: ThemeData().textTheme.apply(
      fontFamily: AppConstants.appFontFamilyName,
    ),
  );
}