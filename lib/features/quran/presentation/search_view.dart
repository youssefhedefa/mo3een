
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_cubit/search_states.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_tabs_cubit/search_tabs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_tabs_cubit/search_tabs_states.dart';
import 'package:mo3een/features/quran/presentation/widgets/initial_search_widget.dart';
import 'package:mo3een/features/quran/presentation/widgets/on_search_by_number_success.dart';
import 'package:mo3een/features/quran/presentation/widgets/search_tabs.dart';
import 'package:mo3een/features/quran/presentation/widgets/searched_ayahs_list.dart';
import 'widgets/empty_search.dart';
import 'widgets/surah_result_list.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorHelper.whiteColor,
        elevation: 0,
        shadowColor: AppColorHelper.whiteColor,
        surfaceTintColor: AppColorHelper.whiteColor,
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const InitialSearchWidget(),
            BlocBuilder<SearchCubit, SearchStates>(
              builder: (context, state) {
                if (state is SearchLoadingState) {
                  return const Column(
                    children: [
                      CustomLoadingIndicator(),
                    ],
                  );
                } else if (state is SearchSuccessState) {
                  if (state.searchResults.isEmpty && state.ayahs.isEmpty) {
                    return const EmptySearch();
                  }
                  return Expanded(
                    child: Column(
                      children: [
                        const SearchTabs(),
                        const SizedBox(height: 16),
                        BlocBuilder<SearchTabsCubit,SearchTabsStates>(
                          builder: (context,tabState) {
                            if(tabState is SearchBySurah){
                              return SurahsResultList(
                                results: state.searchResults,
                              );
                            }
                            else{
                              return SearchedAyahsList(
                                ayahs: state.ayahs,
                              );
                            }

                          }
                        ),
                      ],
                    ),
                  );
                } else if (state is SearchByNumberSuccessState) {
                  if (state.searchResults.isEmpty &&
                      state.number < 0 &&
                      state.number > 604) {
                    return const EmptySearch();
                  }
                  return OnSearchByNumberSuccess(
                    number: state.number,
                    searchResults: state.searchResults,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

}
