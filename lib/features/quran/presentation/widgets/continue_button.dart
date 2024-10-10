import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){},
      color: AppColorHelper.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: REdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Text(
          'متابعة',
        style: AppTextStyleHelper.font12BoldPrimary,
      ),
    );
  }
}
