import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:mo3een/features/quran/presentation/widgets/custom_search_field.dart';

class InitialSearchWidget extends StatelessWidget {
  const InitialSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchField(
          enabled: true,
          onChanged: (query) {
            context.read<SearchCubit>().search(query: query);
          },
          searchController: context.read<SearchCubit>().searchController,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
