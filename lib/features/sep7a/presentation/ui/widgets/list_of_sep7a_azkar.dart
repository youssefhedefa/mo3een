import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/sep7a/presentation/cubit/get_sep7a_azkar_cubit/get_sep7a_azkar_cubit.dart';
import 'package:mo3een/features/sep7a/presentation/cubit/get_sep7a_azkar_cubit/get_sep7a_azkar_states.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/sep7a_zekr_item.dart';

class ListOfSep7aAzkar extends StatelessWidget {
  const ListOfSep7aAzkar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSep7aAzkarCubit, GetSep7aAzkarState>(
        builder: (context, state) {
      if (state is GetSep7aAzkarSuccessState) {
        return Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => Sep7aZekrItem(
              title: state.azkar[index].title,
              count: state.azkar[index].count.toString(),
              onTap: () {
                Navigator.pushNamed(context, AppRoutingConstances.sep7aCounter,
                    arguments: state.azkar[index]);
              },
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemCount: state.azkar.length,
          ),
        );
      } else if (state is GetSep7aAzkarLoadingState) {
        return const Expanded(
          child: CustomLoadingIndicator(),
        );
      } else if (state is GetSep7aAzkarErrorState) {
        return Center(
          child: Text(state.error),
        );
      }
      return const Expanded(
        child: SizedBox(),
      );
    });
  }
}
