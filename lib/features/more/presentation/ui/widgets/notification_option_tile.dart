import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';

class NotificationOptionTile extends StatelessWidget {
  const NotificationOptionTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      toggled: value,
      label: title,
      child: Material(
        color: AppColorHelper.lightCoffeeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: AppColorHelper.primaryColor),
        ),
        child: InkWell(
          onTap: () => onChanged(!value),
          borderRadius: BorderRadius.circular(12.r),
          child: SizedBox(
            height: 58.h,
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  SvgPicture.asset(
                    AppIconHelper.bellIcon,
                    width: 24.w,
                    height: 24.h,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColorHelper.primaryColor,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  _CompactToggle(value: value),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactToggle extends StatelessWidget {
  const _CompactToggle({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 42.w,
      height: 24.h,
      padding: REdgeInsets.all(3),
      alignment: value ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: value
            ? AppColorHelper.primaryColor
            : AppColorHelper.lightPrimaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        width: 18.w,
        height: 18.h,
        decoration: const BoxDecoration(
          color: AppColorHelper.whiteColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
