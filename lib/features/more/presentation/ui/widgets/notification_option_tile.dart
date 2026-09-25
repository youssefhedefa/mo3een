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
  }) : onOpenSettings = null;

  const NotificationOptionTile.settings({
    super.key,
    required this.title,
    required this.value,
    required VoidCallback onTap,
  }) : onOpenSettings = onTap,
       onChanged = null;

  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      toggled: onOpenSettings == null ? value : null,
      value: onOpenSettings != null ? (value ? 'مفعّل' : 'متوقف') : null,
      label: title,
      child: Material(
        color: AppColorHelper.lightCoffeeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: const BorderSide(color: AppColorHelper.primaryColor),
        ),
        child: InkWell(
          onTap: onOpenSettings ?? () => onChanged!(!value),
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
                  if (onOpenSettings != null)
                    IconButton(
                      onPressed: onOpenSettings,
                      tooltip: 'إعدادات التذكير',
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: AppColorHelper.primaryColor,
                      ),
                    )
                  else
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
      alignment: !value ? Alignment.centerRight : Alignment.centerLeft,
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
