import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/home/data/models/quran_verse.dart';
import 'package:mo3een/features/home/presentation/cubits/get_random_verse_cubit/get_random_verse_state.dart';
import 'package:quran/quran.dart';

class GetRandomVerseCubit extends Cubit<GetRandomVerseState> {
  GetRandomVerseCubit() : super(GetRandomVerseInitialState());

  Future<void> getRandomVerseCall() async {
    emit(GetRandomVerseLoadingState());
    try {
      int randomSurahNumber = Random().nextInt(114) + 1;
      int randomVerseNumber =
          Random().nextInt(getVerseCount(randomSurahNumber)) + 1;
      final verse = getVerse(randomSurahNumber, randomVerseNumber,verseEndSymbol: true);
      QuranVerse quranVerse = QuranVerse(
        surahName: getSurahNameArabic(randomSurahNumber),
        verseNumber: randomVerseNumber,
        verseText: verse,
      );
      emit(GetRandomVerseLoadedState(verse: quranVerse));
    } catch (e) {
      emit(GetRandomVerseErrorState(message: e.toString()));
    }
  }
}
