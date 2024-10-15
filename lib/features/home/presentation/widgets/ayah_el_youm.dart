import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class AyahElYoum extends StatelessWidget {
  const AyahElYoum({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorHelper.coffeeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'آية اليوم',
                style: AppTextStyleHelper.font14BoldPrimary,
              ),
              const Spacer(),
              Text(
                'سورة النساء (64)',
                style: AppTextStyleHelper.font14BoldPrimary,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '﴿ وَمَا أَرْسَلْنَا مِنْ رَسُولٍ إِلَّا لِيُطَاعَ بِإِذْنِ اللَّهِ وَلَوْ أَنَّهُمْ إِذْ ظَلَمُوا أَنْفُسَهُمْ جَاءُوكَ فَاسْتَغْفَرُوا اللَّهَ وَاسْتَغْفَرَ لَهُمُ الرَّسُولُ لَوَجَدُوا اللَّهَ تَوَّابًا رَحِيمًا ﴾',
            style: AppTextStyleHelper.font14RegularPrimary,
          ),
        ],
      ),
    );
  }
}
