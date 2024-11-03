import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/quran/presentation/cubits/quran_tabs_cubit/quran_tabs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/quran_tabs_cubit/quran_tabs_states.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_item.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranTabsCubit, QuranTabsState>(
      builder: (context, state) {
        //remove sized box
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTabItem(
              title: 'السور',
              isSelected: state is QuranBySurahState,
              onTap: () {
                context.read<QuranTabsCubit>().changeQuranTap(
                      tab: QuranTabs.surah,
                    );
              },
            ),
            const Expanded(
                child: SizedBox(
              width: 8,
            )),
            CustomTabItem(
              title: 'الصفحات',
              isSelected: state is QuranByPageState,
              onTap: () {
                context.read<QuranTabsCubit>().changeQuranTap(
                      tab: QuranTabs.page,
                    );
              },
            ),
            const Expanded(
                child: SizedBox(
              width: 8,
            )),
            CustomTabItem(
              title: 'الأجزاء',
              isSelected: state is QuranByJuzState,
              onTap: () {
                context.read<QuranTabsCubit>().changeQuranTap(
                      tab: QuranTabs.juz,
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
