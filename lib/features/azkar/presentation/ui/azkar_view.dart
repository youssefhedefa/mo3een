import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/azkar/presentation/cubits/azkar_tabs_cubit/azkar_tabs_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/azkar_tabs_cubit/azkar_tabs_states.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_saved_azkar_cubit/get_all_saved_azkar_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_saved_azkar_cubit/get_all_saved_azkar_states.dart';
import 'package:mo3een/features/azkar/presentation/cubits/search_for_zekr_cubit/search_for_zekr_cubit.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/custom_azkar_list.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/custom_azkar_result_builder.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/tabs_list.dart';
import 'package:mo3een/features/quran/presentation/widgets/custom_search_field.dart';

class AzkarView extends StatelessWidget {
  const AzkarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            const SizedBox(
              height: 66,
              width: double.infinity,
            ),
            Text(
              'الأذكار',
              style: AppTextStyleHelper.font16BoldPrimary,
            ),
            SizedBox(
              height: 40.h,
            ),
            const TabsList(),
            SizedBox(
              height: 24.h,
            ),
            BlocBuilder<AzkarTabsCubit, AzkarTabsState>(
              builder: (context, state) {
                if (state is AllAzkarTab) {
                  return Expanded(
                    child: Column(
                      children: [
                        CustomSearchField(
                          enabled: true,
                          autofocus: false,
                          hintText: 'ابحث عن الذكر',
                          searchController: context
                              .read<SearchForZekrCubit>()
                              .searchController,
                          searchFocusNode: context
                              .read<SearchForZekrCubit>()
                              .searchFocusNode,
                          onChanged: (value) {
                            if (value.isEmpty && value != ' ') {
                              context
                                  .read<SearchForZekrCubit>()
                                  .emitInitialState();
                            } else {
                              context
                                  .read<SearchForZekrCubit>()
                                  .searchForZekr(searchValue: value);
                            }
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        const CustomAzkarBuilderResult(),
                      ],
                    ),
                  );
                } else {
                  return BlocBuilder<GetAllSavedAzkarCubit,
                      GetAllSavedAzkarState>(
                    builder: (context, state) {
                      if (state is GetAllSavedAzkarSuccessState) {
                        if (state.azkarList.isEmpty) {
                          return Center(
                            child: Text(
                              'لا توجد أذكار محفوظة',
                              style: AppTextStyleHelper.font16BoldPrimary,
                            ),
                          );
                        }
                        return CustomAzkarList(azkar: state.azkarList);
                      }
                      return const SizedBox();
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
