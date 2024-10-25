import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class CurrentLocationMarker extends StatelessWidget {
  const CurrentLocationMarker({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: AppColorHelper.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 4),
          Text(
            address,
            style: AppTextStyleHelper.font14RegularPrimary,
          ),
        ],
      ),
    );
  }
}
