import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/sep7a/data/models/sep7a_model.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, required this.zekr});

  final Sep7aZekrModel zekr;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 0,
      content: Container(
        height: 200.h,
        padding: REdgeInsets.symmetric(vertical: 24.w, horizontal: 32.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColorHelper.whiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'هل تريد بالفعل حذف الذكر ؟ ',
              style: AppTextStyleHelper.font16BoldBlack,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: REdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'حذف',
                      style: AppTextStyleHelper.font16BoldWhite,
                    ),
                  ),
                  onPressed: () async {
                    await zekr.delete();
                    if (context.mounted) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: AppColorHelper.primaryColor,
                    ),
                  ),
                  child: Padding(
                    padding: REdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'الغاء',
                      style: AppTextStyleHelper.font16BoldPrimary,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
