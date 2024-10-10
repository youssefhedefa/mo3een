import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class SoraHighLightText extends StatelessWidget {
  const SoraHighLightText({super.key});

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
            text: 'البقرة',
            style: AppTextStyleHelper.font12BoldYellow,
          ),
        ],
      ),
    );
  }
}
