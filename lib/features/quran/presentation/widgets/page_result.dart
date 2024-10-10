import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:quran/quran.dart';


class PageResult extends StatelessWidget {
  const PageResult({super.key, required this.number});

  final num number;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            'البحث عن الصفحه رقم $number موجوده في سوره ${getSurahNameArabic(getPageData(number.toInt())[0]['surah'])}',
            style: AppTextStyleHelper.font16BoldPrimary,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'عرض الصفحه',
            style: AppTextStyleHelper.font12RegularPrimary,
          ),
        ),
      ],
    );
  }
}
