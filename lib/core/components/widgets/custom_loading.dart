import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mo3een/core/helpers/animation_helper.dart';


class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
        AppAnimationHelper.loadingAnimation,
        width: 100,
        height: 60.h,
      alignment: Alignment.center,
    );
  }
}
