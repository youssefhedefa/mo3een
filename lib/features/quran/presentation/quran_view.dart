import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/quran_tabs_cubit/quran_tabs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/quran_tabs_cubit/quran_tabs_states.dart';
import 'package:mo3een/features/quran/presentation/widgets/all_juz_list.dart';
import 'package:mo3een/features/quran/presentation/widgets/all_surahs_list.dart';
import 'package:mo3een/features/quran/presentation/widgets/continue_reading.dart';
import 'package:mo3een/features/quran/presentation/widgets/custom_search_field.dart';
import 'package:mo3een/features/quran/presentation/widgets/quran_pages_list.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_bar.dart';

class QuranView extends StatelessWidget {
  const QuranView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 66,
              width: double.infinity,
            ),
            Text(
              'القرآن الكريم',
              style: AppTextStyleHelper.font16BoldPrimary,
            ),
            const SizedBox(height: 24),
            const ContinueReading(),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutingConstances.search).then((_){
                  if(context.mounted){
                    context.read<GetMarkCubit>().getMark();
                  }
                });
              },
              child: const CustomSearchField(
                enabled: false,
              ),
            ),
            const SizedBox(height: 16),
            const CustomTabBar(),
            const SizedBox(height: 16),
            BlocBuilder<QuranTabsCubit, QuranTabsState>(
                builder: (context, state) {
              if (state is QuranBySurahState) {
                return const AllSurahList();
              } else if (state is QuranByJuzState) {
                return const AllJuzList();
              } else if (state is QuranByPageState) {
                return const QuranPagesList();
              }
              return const SizedBox();
            }),
          ],
        ),
      ),
    );
  }
}
