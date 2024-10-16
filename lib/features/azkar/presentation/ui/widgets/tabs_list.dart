import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/azkar/presentation/cubits/azkar_tabs_cubit/azkar_tabs_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/azkar_tabs_cubit/azkar_tabs_states.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_item.dart';

class TabsList extends StatelessWidget {
  const TabsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarTabsCubit,AzkarTabsState>(
      builder: (context,state) {
        return Row(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomTabItem(
                title: 'كل الأذكار',
                isSelected: state is AllAzkarTab,
                onTap: (){
                  context.read<AzkarTabsCubit>().selectAllAzkarTab();
                },
              ),
            ),
            SizedBox(width: 40.w,),
            Expanded(
              child: CustomTabItem(
                title: 'الاذكار المحفوظة',
                isSelected: state is MemorizedAzkarTab,
                onTap: (){
                  context.read<AzkarTabsCubit>().selectMemorizedAzkarTab();
                },
              ),
            ),
          ],
        );
      }
    );
  }
}
