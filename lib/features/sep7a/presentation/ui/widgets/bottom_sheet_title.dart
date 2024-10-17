import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppIconHelper.editIcon,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'اضافة ذكر الى المسبحة',
          style: AppTextStyleHelper.font14BoldPrimary,
        ),
      ],
    );
  }
}
