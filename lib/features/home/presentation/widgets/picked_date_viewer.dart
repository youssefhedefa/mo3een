import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/home/presentation/cubits/get_date_cubit/get_date_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_date_cubit/get_date_states.dart';

class PickedDateViewer extends StatelessWidget {
  const PickedDateViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDateCubit, GetDateStates>(
      builder: (context, state) {
        if (state is GetDateLoadingState) {
          return const CustomLoadingIndicator();
        }
        if (state is GetDateSuccessState) {
          return Padding(
            padding: REdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              state.pickedDate,
              style: AppTextStyleHelper.font12RegularPrimary,
              textAlign: TextAlign.center,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
