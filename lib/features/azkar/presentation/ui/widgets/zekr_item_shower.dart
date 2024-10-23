import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/repeate_button.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/share_button.dart';


class ZekItemShower extends StatelessWidget {
  const ZekItemShower({super.key, required this.zekr, required this.count, required this.zekrIndex});

  final String zekr;
  final int zekrIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 12.w,vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColorHelper.primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            zekr.replaceAll('. ', '.\n'),
            style: AppTextStyleHelper.font18RegularPrimary.copyWith(
              fontFamily: AppConstants.quranFontFamilyName,
            ),
          ),
          SizedBox(
            height: 18.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RepeatButton(
                index: zekrIndex,
                maxCount: count,
              ),
              const ShareButton(),
            ],
          ),
        ],
      ),
    );
  }
}
