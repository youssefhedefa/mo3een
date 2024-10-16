import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/components/widgets/custom_loading.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/azkar/presentation/cubits/azkar_tabs_cubit/azkar_tabs_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/azkar_tabs_cubit/azkar_tabs_states.dart';
import 'package:mo3een/features/azkar/presentation/cubits/search_for_zekr_cubit/search_for_zekr_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/search_for_zekr_cubit/search_for_zekr_states.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/all_azkar_list.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/custom_zekr_item.dart';
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
            Expanded(
              child: BlocBuilder<AzkarTabsCubit,AzkarTabsState>(
                builder: (context, state) {
                  if (state is AllAzkarTab) {
                    return Column(
                      children: [
                        CustomSearchField(
                          enabled: true,
                          autofocus: false,
                          hintText: 'ابحث عن الذكر',
                          searchController:
                          context.read<SearchForZekrCubit>().searchController,
                          searchFocusNode:
                          context.read<SearchForZekrCubit>().searchFocusNode,
                          onChanged: (value) {
                            if (value.isEmpty && value != ' ') {
                              context.read<SearchForZekrCubit>().emitInitialState();
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
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAzkarList extends StatelessWidget {
  const CustomAzkarList({super.key, required this.azkar});

  final List<AzkarModel> azkar;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CustomZekrItem(
            zekr: azkar[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: azkar.length,
      ),
    );
  }
}

class CustomAzkarBuilderResult extends StatelessWidget {
  const CustomAzkarBuilderResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchForZekrCubit, SearchForZekrState>(
      builder: (context, state) {
        if (state is SearchForZekrInitialState) {
          return BlocBuilder<AzkarTabsCubit, AzkarTabsState>(
            builder: (context, state) {
              return const AllAzkarList();
            },
          );
        }
        else if (state is SearchForZekrLoadingState) {
          return const Center(
            child: CustomLoadingIndicator(),
          );
        } else if (state is SearchForZekrSuccessState) {
          return CustomAzkarList(
            azkar: state.azkar,
          );
        } else if (state is SearchForZekrErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

