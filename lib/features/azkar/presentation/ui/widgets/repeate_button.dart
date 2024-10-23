import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/azkar/presentation/cubits/zekr_counter_cubit/zekr_counter_cubit.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_item.dart';

class RepeatButton extends StatelessWidget {
  const RepeatButton({super.key, required this.index, required this.maxCount,});

  final int index;
  final int maxCount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ZekrCounterCubit,ZekrCounterState>(
      builder: (context,state) {
        if(state is ZekrCounterIncrement){
          int count = context.read<ZekrCounterCubit>().getCount(index);
          return CustomTabItem(
            title: 'تكرار ($count/$maxCount) ',
            isSelected: true,
            isActive: count != maxCount,
            onTap: () {
              if(count == maxCount){
                return;
              }
              context.read<ZekrCounterCubit>().increment(index: index);
            },
          );
        }
        return CustomTabItem(
          title: 'تكرار (0/$maxCount) ',
          isSelected: true,
          isActive: 0 != maxCount,
          onTap: () {
            context.read<ZekrCounterCubit>().increment(index: index);
          },
        );
      }
    );
  }
}
