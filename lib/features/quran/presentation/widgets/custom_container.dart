import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';


class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(vertical: 10.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColorHelper.lightCoffeeColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColorHelper.primaryColor,
          width: 1.4,
        ),
      ),
      child: child,
    );
  }
}
