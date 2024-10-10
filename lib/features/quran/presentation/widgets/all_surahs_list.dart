import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_all_surahs_cubit/get_all_surahs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_all_surahs_cubit/get_all_surahs_states.dart';
import 'package:mo3een/features/quran/presentation/widgets/surah_container.dart';

class AllSurahList extends StatelessWidget {
  const AllSurahList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllSurahsCubit, GetAllSurahsStates>(
        builder: (context, state) {
      if (state is GetAllSurahsLoadingState) {
        return const Center(
          child: CustomLoadingIndicator(),
        );
      }
      if (state is GetAllSurahsSuccessState) {
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => SurahContainer(
              surah: state.surahs[index],
            ),
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => const SizedBox(
              height: 12,
            ),
            itemCount: state.surahs.length,
          ),
        );
      }
      return const SizedBox();
    });
  }
}
