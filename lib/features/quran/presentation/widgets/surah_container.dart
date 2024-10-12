import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';


class SurahContainer extends StatelessWidget {
  const SurahContainer({super.key, required this.surah, this.onTap});

  final SuraEntity surah;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: REdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColorHelper.lightCoffeeColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColorHelper.primaryColor,
            width: 1.4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'سورة ${surah.name}',
                  style: AppTextStyleHelper.font16BoldPrimary.copyWith(
                    fontFamily: 'AmiriQuran',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'آياتها ${surah.ayahsNumber} - ${surah.revelationType}',
                    style: AppTextStyleHelper.font12RegularPrimary,
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  AppIconHelper.numberIcon,
                  width: 44.w,
                  height: 44.h,
                ),
                Text(
                  surah.number.toString(),
                  style: AppTextStyleHelper.font16RegularPrimary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
