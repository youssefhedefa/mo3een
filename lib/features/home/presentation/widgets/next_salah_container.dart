import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/image_helper.dart';
import 'package:mo3een/features/home/presentation/widgets/next_salah_text.dart';

class NextSalahContainer extends StatelessWidget {
  const NextSalahContainer({super.key, required this.nextPrayer, required this.remainHours, required this.remainMinutes, this.isLoading});

  final String nextPrayer;
  final int remainHours;
  final int remainMinutes;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: AppColorHelper.coffeeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: isLoading ?? false ? const CustomLoadingIndicator() : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NextSalahText(
                  title: 'الصلاة القادمة هي صلاة ',
                  subTitle: nextPrayer,
                  svgIcon: AppIconHelper.mosqueIcon,
                ),
                const SizedBox(height: 16),
                NextSalahText(
                  title: 'باقي على صلاة $nextPrayer',
                  subTitle: '$remainHours ساعة و $remainMinutes دقيقة ',
                  svgIcon: AppIconHelper.timeIcon,
                ),
              ],
            ),
          ),
          Center(
            child: Image.asset(
              AppImageHelper.prayerImage,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
