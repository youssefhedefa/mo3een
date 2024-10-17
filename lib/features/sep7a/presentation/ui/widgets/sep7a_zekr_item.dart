import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/quran/presentation/widgets/custom_container.dart';

class Sep7aZekrItem extends StatelessWidget {
  const Sep7aZekrItem({super.key, required this.title, required this.count, this.onTap});

  final String title;
  final String count;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 8.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyleHelper.font14RegularPrimary,
              ),
            ),
            Text(
              '$count مرة ',
              style: AppTextStyleHelper.font14RegularPrimary.copyWith(
                fontFamily: AppConstants.quranFontFamilyName
              ),
            ),
          ],
        ),
      ),
    );
  }
}
