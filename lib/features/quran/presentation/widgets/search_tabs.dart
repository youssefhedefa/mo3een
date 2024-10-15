import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_tabs_cubit/search_tabs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_tabs_cubit/search_tabs_states.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_item.dart';

class SearchTabs extends StatelessWidget {
  const SearchTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTabsCubit, SearchTabsStates>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomTabItem(
              title: 'السور',
              isSelected: state is SearchBySurah,
              onTap: () {
                context.read<SearchTabsCubit>().searchType(
                      type: SearchType.SurahType,
                      context: context,
                    );
              },
            ),
            CustomTabItem(
              title: 'الايات',
              isSelected: state is SearchByAyah,
              onTap: () {
                context.read<SearchTabsCubit>().searchType(
                      type: SearchType.AyahType,
                      context: context,
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
