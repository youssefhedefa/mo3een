import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class PrayerContainer extends StatelessWidget {
  const PrayerContainer({super.key, required this.icon, required this.prayer, required this.time, required this.hisTurn});

  final String icon;
  final String prayer;
  final String time;
  final bool hisTurn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 12.h,horizontal: 14.w),
      decoration: BoxDecoration(
        color: hisTurn ? AppColorHelper.primaryColor : AppColorHelper.lightCoffeeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
              icon,
            colorFilter: ColorFilter.mode(
              hisTurn ? AppColorHelper.whiteColor : AppColorHelper.primaryColor,
              BlendMode.srcIn,
            )
          ),
          SizedBox(width: 12.w),
          Text(
            prayer,
            style: hisTurn ? AppTextStyleHelper.font14BoldWhite: AppTextStyleHelper.font14BoldPrimary,
          ),
          const Spacer(),
          Text(
            timeFormatting(time: time),
            style: hisTurn ? AppTextStyleHelper.font14BoldWhite: AppTextStyleHelper.font14BoldPrimary,
          ),
        ],
      ),
    );
  }
  timeFormatting({required String time}){
    final hour = int.parse(time.split(':')[0]);
    final minute = time.split(':')[1];
    final period = hour >= 12 ? 'م' : 'ص';
    final formattedHour = hour > 12 ? hour - 12 : hour;
    return '$formattedHour:$minute $period';
  }
}
