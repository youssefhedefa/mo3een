import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';



class Sep7aZekrCounter extends StatelessWidget {
  const Sep7aZekrCounter({super.key, required this.title, required this.count});

  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          Container(
            padding: REdgeInsets.all(8.0),
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColorHelper.primaryColor,
              ),
            ),
            child: Text(
              count,
              style: AppTextStyleHelper.font14RegularPrimary,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            //title,
            addToTotalNewLine(text: title),
            style: AppTextStyleHelper.font14RegularPrimary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  String addToTotalNewLine({required String text}) {
    if(text == 'الاجمالي') {
      return '$text\n';
    }
    return text;
  }
}
