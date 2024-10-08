import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
abstract class AppTextStyleHelper{
  static const TextStyle font10BoldPrimary = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    color: AppColorHelper.primaryColor,
  );

  static const TextStyle font10RegularLightPrimary = TextStyle(
    fontSize: 10,
    color: AppColorHelper.lightPrimaryColor,
  );
}