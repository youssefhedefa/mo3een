import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/tabs_list.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            const SizedBox(
              height: 66,
              width: double.infinity,
            ),
            Text(
                'الأذكار',
              style: AppTextStyleHelper.font16BoldPrimary,
            ),
             SizedBox(
              height: 40.h,
            ),
            const TabsList(),
          ],
        ),
      ),
    );
  }
}
