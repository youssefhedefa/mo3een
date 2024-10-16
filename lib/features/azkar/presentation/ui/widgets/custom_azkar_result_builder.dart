import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/azkar/presentation/cubits/search_for_zekr_cubit/search_for_zekr_states.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/all_azkar_list.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/custom_azkar_list.dart';
import '../../cubits/search_for_zekr_cubit/search_for_zekr_cubit.dart';


class CustomAzkarBuilderResult extends StatelessWidget {
  const CustomAzkarBuilderResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchForZekrCubit, SearchForZekrState>(
      builder: (context, state) {
        if (state is SearchForZekrInitialState) {
          return const AllAzkarList();
        }
        else if (state is SearchForZekrLoadingState) {
          return const Center(
            child: CustomLoadingIndicator(),
          );
        } else if (state is SearchForZekrSuccessState) {
          if(state.azkar.isEmpty){
            return Center(
              child: Text(
                  'عفوا لا يوجد نتائج',
                style:AppTextStyleHelper.font16BoldPrimary ,
              ),
            );
          }
          return CustomAzkarList(
            azkar: state.azkar,
          );
        } else if (state is SearchForZekrErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
