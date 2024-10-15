import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';



class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'مرحباً، زادك الله هُدى',
              style: AppTextStyleHelper.font18BoldPrimary,
            ),
            SizedBox(width: 8.w),
            SvgPicture.asset(
              AppIconHelper.handIcon,
              width: 24.w,
              height: 24.h,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'اللَهُمَّ صلِّ وسَلِم وبَارِك على سيدنا محمد (ﷺ)',
          style: AppTextStyleHelper.font14RegularPrimary60,
        ),
      ],
    );
  }
}
