import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';
import 'package:mo3een/features/quran/data/models/surahs_from_juz.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/widgets/custom_container.dart';
import 'package:quran/quran.dart';

class AllJuzList extends StatelessWidget {
  const AllJuzList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => CustomContainer(
          onTap: () {
            List<SurahsFromJuzModel> surahsFromJuzModel =
                getSurahAndVersesFromJuz(index + 1)
                    .entries
                    .map((e) => SurahsFromJuzModel.fromMap({e.key: e.value}))
                    .toList();
            int pageNumber = getPageNumber(surahsFromJuzModel[0].surahNumber, surahsFromJuzModel[0].verses[0]);
            Navigator.pushNamed(
              context,
              AppRoutingConstances.quranPage,
              arguments: QuranPageModel(
                pageNumber: pageNumber,
              ),
            ).then((_){
              if(context.mounted){
                context.read<GetMarkCubit>().getMark();
              }
            });
          },
          child: Text(
            AppConstants.juzNumbers[index],
            style: AppTextStyleHelper.font16RegularPrimary.copyWith(
              fontFamily: AppConstants.quranFontFamilyName,
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          height: 12.h,
        ),
        itemCount: AppConstants.juzNumbers.length,
      ),
    );
  }
}
