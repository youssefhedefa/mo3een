import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:quran/quran.dart';

class SoraHighLightText extends StatelessWidget {
  const SoraHighLightText({super.key, required this.surah});

  final int surah;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'توقفت عند سورة ',
            style: AppTextStyleHelper.font12BoldWhite,
          ),
          TextSpan(
            text: getSurahNameArabic(surah),
            style: AppTextStyleHelper.font12BoldYellow,
          ),
        ],
      ),
    );
  }
}
