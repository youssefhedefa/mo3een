import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/image_helper.dart';
import 'package:mo3een/features/home/presentation/widgets/next_salah_text.dart';


class NextSalahContainer extends StatelessWidget {
  const NextSalahContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorHelper.coffeeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NextSalahText(
                  title: 'الصلاة القادمة هي صلاة ',
                  subTitle: 'المغرب',
                  svgIcon: AppIconHelper.mosqueIcon,
                ),
                SizedBox(height: 16),
                NextSalahText(
                  title: 'باقي على صلاة المغرب',
                  subTitle: '2 ساعة و 15 دقيقة ',
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
