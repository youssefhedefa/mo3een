import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24.0),
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 42, width: double.infinity),
                    Text(
                      'القرآن الكريم',
                      style: AppTextStyleHelper.font16BoldPrimary,
                    ),
                    const SizedBox(height: 24),
                    const ContinueReading(),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutingConstances.search,
                        ).then((_) {
                          if (context.mounted) {
                            context.read<GetMarkCubit>().getMark();
                          }
                        });
                      },
                      child: const CustomSearchField(enabled: false),
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _QuranTabBarHeaderDelegate(
                  height: 64.h,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ],
            body: BlocBuilder<QuranTabsCubit, QuranTabsState>(
              builder: (context, state) {
                if (state is QuranBySurahState) {
                  return const AllSurahList();
                } else if (state is QuranByJuzState) {
                  return const AllJuzList();
                } else if (state is QuranByPageState) {
                  return const QuranPagesList();
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _QuranTabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  const _QuranTabBarHeaderDelegate({
    required this.height,
    required this.backgroundColor,
  });

  final double height;
  final Color backgroundColor;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ColoredBox(
      color: backgroundColor,
      child: Column(
        children: [
          SizedBox(height: 16.h),
          const CustomTabBar(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _QuranTabBarHeaderDelegate oldDelegate) {
    return height != oldDelegate.height ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
