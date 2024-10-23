import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class CustomTabItem extends StatelessWidget {
  const CustomTabItem({super.key, required this.title, required this.isSelected, this.onTap, this.isActive});

  final String title;
  final bool isSelected;
  final Function()? onTap;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? ( isActive ?? true ? AppColorHelper.primaryColor : AppColorHelper.lightPrimaryColor) : AppColorHelper.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColorHelper.primaryColor,
            width: 1.5,
          ),
        ),
        child: Text(
          title,
          style: isSelected ? AppTextStyleHelper.font12BoldWhite : AppTextStyleHelper.font12BoldPrimary,
        ),
      ),
    );
  }
}
