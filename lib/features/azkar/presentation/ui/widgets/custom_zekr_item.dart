import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/quran/presentation/widgets/custom_container.dart';


class CustomZekrItem extends StatelessWidget {
  const CustomZekrItem({super.key, required this.zekr});

  final AzkarModel zekr;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                zekr.category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyleHelper.font16BoldPrimary,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.bookmark_border,
                color: AppColorHelper.primaryColor,
                size: 30.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
