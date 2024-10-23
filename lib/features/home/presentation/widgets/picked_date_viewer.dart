import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/notify_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/home/presentation/cubits/get_date/get_date_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_date/get_date_states.dart';

class PickedDateViewer extends StatelessWidget {
  const PickedDateViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDateCubit, GetDateStates>(builder: (context, state) {
      if (state is GetDateLoadingState) {
        return const CustomLoadingIndicator();
      }
      if (state is GetDateSuccessState) {
        return Padding(
          padding: REdgeInsets.symmetric(vertical: 14.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {

                  AppNotifyHelper.sendNotify();

                  // context
                  //     .read<GetDateCubit>()
                  //     .getPreviousDate(state.pickedDate);
                },
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      initialDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        context
                            .read<GetDateCubit>()
                            .getDateFromPicker(value);
                      }
                    });
                  },
                  child: Text(
                    state.pickedDate,
                    style: AppTextStyleHelper.font12RegularPrimary,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  AppNotifyHelper.sendNotify();
                  //context.read<GetDateCubit>().getNextDate(state.pickedDate);
                },
              ),
            ],
          ),
        );
      }
      return const SizedBox();
    });
  }
}
