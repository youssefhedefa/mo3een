import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class PermissionErrorWidget extends StatelessWidget {
  const PermissionErrorWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'الرجاء تفعيل الموقع واعاده المحاوله',
          textAlign: TextAlign.center,
          style: AppTextStyleHelper.font16SemiBoldPrimary,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
