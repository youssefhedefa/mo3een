import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/add_sep7a_zekr_button.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/bottom_sheet_title.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/custom_text_field.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetTitle(),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(
            title: 'ادخل الذكر ',
            controller: TextEditingController(),
          ),
          const SizedBox(
            height: 24,
          ),
          CustomTextField(
            title: 'ادخل عدد حبات الذكر ',
            controller: TextEditingController(),
            type: TextInputType.number,
          ),
          const SizedBox(
            height: 40,
          ),
          AddSep7aZekrButton(
            onPressed: () {},
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
