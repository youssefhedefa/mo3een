import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class NextSalahText extends StatelessWidget {
  const NextSalahText({super.key, required this.svgIcon, required this.title, required this.subTitle});

  final String svgIcon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          svgIcon,
          height: 28,
          width: 28,
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyleHelper.font14BoldPrimary,
            ),
            const SizedBox(height: 4),
            Text(
              subTitle,
              style: AppTextStyleHelper.font14RegularPrimary60,
            ),
          ],
        ),
      ],
    );
  }
}
