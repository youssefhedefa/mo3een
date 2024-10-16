import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_item.dart';
import 'package:quran/quran.dart';

class QuranPageHeader extends StatelessWidget {
  const QuranPageHeader({super.key, required this.page});

  final int page;

  @override
  Widget build(BuildContext context) {
    final data = getPageData(page);
    final getSura = data[0]['surah'];
    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 24.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getSurahNameArabic(getSura),
            style: AppTextStyleHelper.font14RegularPrimary,
          ),
          CustomTabItem(title: page.toString(), isSelected: false),
          IconButton(
            onPressed: () {
              Navigator.pop(context,true);
            },
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: AppColorHelper.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
