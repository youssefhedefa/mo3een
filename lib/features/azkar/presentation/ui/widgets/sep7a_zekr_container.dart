import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/sep7a_zekr_counter.dart';

class Sep7aZekrContainer extends StatelessWidget {
  const Sep7aZekrContainer({super.key});

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
            'سبحان الله وبحمده سبحان الله العظيم',
            textAlign: TextAlign.center,
            style: AppTextStyleHelper.font18BoldPrimary,
          ),
          const SizedBox(
            height: 24,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Sep7aZekrCounter(
                title: 'عدد الحبات',
                count: '100',
              ),
              Sep7aZekrCounter(
                title: 'العدد الحالي',
                count: '55',
              ),
              Sep7aZekrCounter(
                title: 'عدد الدورات',
                count: '1',
              ),
              Sep7aZekrCounter(
                title: 'الاجمالي',
                count: '1',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
