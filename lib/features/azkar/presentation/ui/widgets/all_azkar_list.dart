import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_azkar_cubit/get_all_azkar_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_azkar_cubit/get_all_azkar_states.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/custom_azkar_list.dart';

class AllAzkarList extends StatelessWidget {
  const AllAzkarList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllAzkarCubit,GetAllAzkarState>(
      builder: (context,state) {
        if(state is GetAllAzkarSuccessState){
          return CustomAzkarList(azkar: state.azkar);
        }
        return const SizedBox();
      }
    );
  }
}
