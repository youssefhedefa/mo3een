import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/sep7a_zekr_counter.dart';

class Sep7aZekrContainer extends StatelessWidget {
  const Sep7aZekrContainer({super.key, required this.title, required this.count, required this.currentCount, required this.cycleNumber, required this.totalCount});

  final String title;
  final int count;
  final int currentCount;
  final int cycleNumber;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColorHelper.lightCoffeeColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColorHelper.primaryColor,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyleHelper.font18BoldPrimary,
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Sep7aZekrCounter(
                title: 'عدد الحبات',
                count: count.toString(),
              ),
              Sep7aZekrCounter(
                title: 'العدد الحالي',
                count: currentCount.toString(),
              ),
              Sep7aZekrCounter(
                title: 'عدد الدورات',
                count: cycleNumber.toString(),
              ),
              Sep7aZekrCounter(
                title: 'الاجمالي',
                count: totalCount.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
