import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
abstract class AppTextStyleHelper{
  static TextStyle font10BoldPrimary = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
    color: AppColorHelper.primaryColor,
  );

  static TextStyle font10RegularLightPrimary = TextStyle(
    fontSize: 10.sp,
    color: AppColorHelper.lightPrimaryColor,
  );

  static TextStyle font14RegularPrimary60 = TextStyle(
    fontSize: 14.sp,
    color: AppColorHelper.primaryColor.withOpacity(0.6),
  );

  static TextStyle font18BoldPrimary = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColorHelper.primaryColor,
  );


}