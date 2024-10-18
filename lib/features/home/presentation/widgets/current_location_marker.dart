import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/home/presentation/cubits/get_current_location_cubit/get_current_location_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_current_location_cubit/get_current_location_states.dart';


class CurrentLocationMarker extends StatelessWidget {
  const CurrentLocationMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCurrentLocationCubit,GetCurrentLocationState>(
      builder: (context,state) {
        if(state is GetCurrentLocationLoading){
          return const Center(
            child: CustomLoadingIndicator(),
          );
        }
        if(state is GetCurrentLocationFailed){
          return Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColorHelper.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 4),
              Text(
                'موقعك الحالي : غير متوفر',
                style: AppTextStyleHelper.font14RegularPrimary,
              ),
            ],
          );
        }
        else if(state is GetCurrentLocationSuccess){
          return Row(
            children: [
              const Icon(
                Icons.location_on,
                color: AppColorHelper.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 4),
              Text(
                //'موقعك الحالي : فوة - كفر الشيخ',
                state.address,
                style: AppTextStyleHelper.font14RegularPrimary,
              ),
            ],
          );
        }
        return Row(
          children: [
            const Icon(
              Icons.location_on,
              color: AppColorHelper.primaryColor,
              size: 24,
            ),
            const SizedBox(width: 4),
            Text(
              'موقعك الحالي : فوة - كفر الشيخ',
              style: AppTextStyleHelper.font14RegularPrimary,
            ),
          ],
        );
      }
    );
  }
}
