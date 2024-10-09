import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/home/presentation/widgets/prayer_container.dart';

class PrayerTimesList extends StatelessWidget {
  const PrayerTimesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: REdgeInsets.only(bottom: 14.h),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => PrayerContainer(
        icon: AppConstants.testPrayersList[index].icon,
        prayer: AppConstants.testPrayersList[index].prayer,
        time: AppConstants.testPrayersList[index].time,
        hisTurn: AppConstants.testPrayersList[index].hisTurn,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 16,
      ),
      itemCount: AppConstants.testPrayersList.length,
    );
  }
}
