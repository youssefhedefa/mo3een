import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class EmptySearch extends StatelessWidget {
  const EmptySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'لا توجد نتائج بحث',
        style: AppTextStyleHelper.font16BoldPrimary,
      ),
    );
  }
}
