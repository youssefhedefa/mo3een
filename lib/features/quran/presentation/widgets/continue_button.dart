import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.page});

  final QuranPageModel page;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).pushNamed(
          AppRoutingConstances.quranPage,
          arguments: page,
        );
      },
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
