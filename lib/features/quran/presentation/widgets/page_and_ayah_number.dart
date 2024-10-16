import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class PageAndAyahNumber extends StatelessWidget {
  const PageAndAyahNumber({super.key, required this.page, required this.ayah});

  final int page ;
  final int ayah ;

  @override
  Widget build(BuildContext context) {
    return Text(
      'صفحة $page الآية رقم $ayah',
      style: AppTextStyleHelper.font12BoldYellow,
    );
  }
}
