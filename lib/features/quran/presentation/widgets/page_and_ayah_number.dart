import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class PageAndAyahNumber extends StatelessWidget {
  const PageAndAyahNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'صفحة 34 الآية رقم 217',
      style: AppTextStyleHelper.font12BoldYellow,
    );
  }
}
