import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/quran/domain/entities/ayah_entity.dart';

class SearchedAyahsList extends StatelessWidget {
  const SearchedAyahsList({super.key, required this.ayahs});

  final dynamic ayahs ;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => AyahItem(
          ayah: ayahs[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: ayahs.length,
      ),
    );
  }
}

class AyahItem extends StatelessWidget {
  const AyahItem({super.key, required this.ayah});

  final AyahEntity ayah;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorHelper.coffeeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'سورة ${ayah.suraName} (${ayah.ayahNumber})',
                style: AppTextStyleHelper.font14BoldPrimary.copyWith(
                  fontFamily: AppConstants.quranFontFamilyName,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '﴿ ${ayah.ayah} ﴾',
            style: AppTextStyleHelper.font14RegularPrimary.copyWith(
              fontFamily: AppConstants.quranFontFamilyName,
            ),
          ),
        ],
      ),
    );
  }
}
