import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/home/presentation/cubits/get_random_verse_cubit/get_random_verse_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_random_verse_cubit/get_random_verse_state.dart';


class AyahElYoum extends StatelessWidget {
  const AyahElYoum({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorHelper.coffeeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: BlocBuilder<GetRandomVerseCubit,GetRandomVerseState>(
        builder: (context,state) {
          if(state is GetRandomVerseLoadedState){
            return VerseData(
              surahName: state.verse.surahName,
              verseNumber: state.verse.verseNumber,
              verseText: state.verse.verseText,
            );
          }
          return const VerseData(
            surahName: 'النساء',
            verseNumber: 64,
            verseText: ' وَمَا أَرْسَلْنَا مِنْ رَسُولٍ إِلَّا لِيُطَاعَ بِإِذْنِ اللَّهِ وَلَوْ أَنَّهُمْ إِذْ ظَلَمُوا أَنْفُسَهُمْ جَاءُوكَ فَاسْتَغْفَرُوا اللَّهَ وَاسْتَغْفَرَ لَهُمُ الرَّسُولُ لَوَجَدُوا اللَّهَ تَوَّابًا رَحِيمًا ',
          );
        }
      ),
    );
  }
}

class VerseData extends StatelessWidget {
  const VerseData({super.key, required this.surahName, required this.verseNumber, required this.verseText});

  final String surahName;
  final int verseNumber;
  final String verseText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'آية اليوم',
              style: AppTextStyleHelper.font14BoldPrimary,
            ),
            const Spacer(),
            Text(
              'سورة $surahName ($verseNumber)',
              style: AppTextStyleHelper.font14BoldPrimary,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          '﴿$verseText﴾',
          style: AppTextStyleHelper.font14RegularPrimary.copyWith(
            fontFamily: AppConstants.quranFontFamilyName,
            height: 2,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
