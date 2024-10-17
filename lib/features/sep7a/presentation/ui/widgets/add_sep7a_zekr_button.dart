import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class AddSep7aZekrButton extends StatelessWidget {
  const AddSep7aZekrButton({super.key,required this.onPressed, this.title});

  final void Function() onPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColorHelper.primaryColor,
      minWidth: double.infinity,
      padding: REdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title??'اضافة ذكر ',
        style: AppTextStyleHelper.font14BoldWhite,
      ),
    );
  }
}
