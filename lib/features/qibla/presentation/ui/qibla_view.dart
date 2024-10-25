import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/qibla/presentation/ui/widgets/qibla_direction.dart';

class QiblaView extends StatelessWidget {
  const QiblaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 42,
              width: double.infinity,
            ),
            Text(
              'اتجاة القبلة',
              style: AppTextStyleHelper.font16BoldPrimary,
            ),
            const Expanded(
              child: QiblahDirection(),
            ),
            Text(
              'اتجاه السهم الاحمر يشير الى اتجاه القبلة ',
              textAlign: TextAlign.center,
              style: AppTextStyleHelper.font16BoldPrimary,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'ضع الهاتف على مستوى افقي للحصول على افضل نتيجة',
              textAlign: TextAlign.center,
              style: AppTextStyleHelper.font16BoldPrimary.copyWith(
                color: AppColorHelper.primaryColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
