import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/sep7a/presentation/cubit/add_sep7a_zekr_cubit/add_sep7a_zekr_cubit.dart';
import 'package:mo3een/features/sep7a/presentation/cubit/get_sep7a_azkar_cubit/get_sep7a_azkar_cubit.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/add_sep7a_zekr_button.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/custom_bottom_sheet.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/list_of_sep7a_azkar.dart';

class Sep7aView extends StatelessWidget {
  const Sep7aView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(
              height: 42,
              width: double.infinity,
            ),
            Text(
              'اذكار السبحة الألكترونية',
              style: AppTextStyleHelper.font16BoldPrimary,
            ),
            const SizedBox(
              height: 24,
            ),
            const ListOfSep7aAzkar(),
            const SizedBox(
              height: 14,
            ),
            AddSep7aZekrButton(
              onPressed: () {
                showBottomSheet(context);
              },
            ),
          ],
        ),
      ),
    );
  }
  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      backgroundColor: AppColorHelper.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => AddSep7aZekrCubit(),
            child: const CustomBottomSheet()
        );
      },
    ).then((_){
      if(context.mounted){
        context.read<GetSep7aAzkarCubit>().getSep7aAzkar();
      }
    });
  }
}
