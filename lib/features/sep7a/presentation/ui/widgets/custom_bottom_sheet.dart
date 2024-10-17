import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/sep7a/data/models/sep7a_model.dart';
import 'package:mo3een/features/sep7a/presentation/cubit/add_sep7a_zekr_cubit/add_sep7a_zekr_cubit.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/add_sep7a_zekr_button.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/bottom_sheet_title.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/custom_text_field.dart';
import 'package:string_validator/string_validator.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(
         top: 24.0,
        right: 24.0,
        left: 24.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: context.read<AddSep7aZekrCubit>().formKey,
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
              controller: context.read<AddSep7aZekrCubit>().titleController,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomTextField(
              title: 'ادخل عدد حبات الذكر ',
              controller: context.read<AddSep7aZekrCubit>().countController,
              type: TextInputType.number,
            ),
            const SizedBox(
              height: 40,
            ),
            AddSep7aZekrButton(
              onPressed: () {
                addZekr(context);
              },
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  addZekr(BuildContext context) {
    if (context.read<AddSep7aZekrCubit>().formKey.currentState!.validate() && isInt(
        context.read<AddSep7aZekrCubit>().countController.text)) {
      context.read<AddSep7aZekrCubit>().addSep7aZekr(
            zekr: Sep7aZekrModel(
              id: DateTime.now().millisecondsSinceEpoch,
              title: context.read<AddSep7aZekrCubit>().titleController.text,
              count: int.parse(
                  context.read<AddSep7aZekrCubit>().countController.text),
            ),
          );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('الرجاء ادخال البيانات بشكل صحيح'),
        ),
      );
      Navigator.pop(context);
    }
  }
}
