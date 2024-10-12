import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/quran/presentation/cubits/quran_tabs_cubit/quran_tabs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/quran_tabs_cubit/quran_tabs_states.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_item.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranTabsCubit, QuranTabsState>(
      builder: (context, state) {
        return SizedBox(
          height: 36.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTabItem(
                title: 'السور',
                isSelected: state is QuranBySurahState,
                onTap: () {
                  context.read<QuranTabsCubit>().changeQuranTap(
                        tab: QuranTabs.Surah,
                      );
                },
              ),
              CustomTabItem(
                title: 'الأجزاء',
                isSelected: state is QuranByJuzState,
                onTap: () {
                  context.read<QuranTabsCubit>().changeQuranTap(
                        tab: QuranTabs.Juz,
                      );
                },
              ),
              CustomTabItem(
                title: 'الصفحات',
                isSelected: state is QuranByPageState,
                onTap: () {
                  context.read<QuranTabsCubit>().changeQuranTap(
                        tab: QuranTabs.Page,
                      );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
