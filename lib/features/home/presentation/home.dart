import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/home/presentation/widgets/home_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.only(top: 76.h, left: 24.w, right: 24.w,bottom: 14.h),
        child: const Column(
          children: [
            HomeHeader(),
          ],
        ),
      ),
    );
  }
}
