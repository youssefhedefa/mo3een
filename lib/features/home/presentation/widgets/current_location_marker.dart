import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class CurrentLocationMarker extends StatelessWidget {
  const CurrentLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on,
          color: AppColorHelper.primaryColor,
          size: 24,
        ),
        const SizedBox(width: 4),
        Text(
          'موقعك الحالي : فوة - كفر الشيخ',
          style: AppTextStyleHelper.font14RegularPrimary,
        ),
      ],
    );
  }
}
