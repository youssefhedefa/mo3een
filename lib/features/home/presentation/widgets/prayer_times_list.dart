import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/home/data/models/prayer_model.dart';
import 'package:mo3een/features/home/presentation/widgets/prayer_container.dart';

class PrayerTimesList extends StatelessWidget {
  const PrayerTimesList({super.key, required this.prayers});

  final List<PrayerModel> prayers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: REdgeInsets.only(bottom: 14.h),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => PrayerContainer(
        icon: prayers[index].icon,
        prayer: prayers[index].prayer,
        time: prayers[index].time,
        hisTurn: prayers[index].hisTurn,
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 16,
      ),
      itemCount: prayers.length,
    );
  }
}
