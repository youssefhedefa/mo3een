import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';
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
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRoutingConstances.quranPage,
              arguments: QuranPageModel(
                pageNumber: number.toInt(),
                suraNumber: getPageData(number.toInt())[0]['surah'],
                ayahNumber: getPageData(number.toInt())[0]['ayah'],
              ),
            );
          },
          child: Text(
            'عرض الصفحه',
            style: AppTextStyleHelper.font12RegularPrimary,
          ),
        ),
      ],
    );
  }
}
