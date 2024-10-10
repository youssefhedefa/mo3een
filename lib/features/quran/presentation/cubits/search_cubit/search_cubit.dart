import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/quran/domain/entities/ayah_entity.dart';
import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';
import 'package:mo3een/features/quran/domain/repo/quran_repo.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_cubit/search_states.dart';
import 'package:quran/quran.dart';
import 'package:string_validator/string_validator.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit({required this.repo}) : super(SearchInitialState());

  final QuranRepo repo;

  TextEditingController searchController = TextEditingController();

  Future<List<SuraEntity>> getAllSurahs() async {
    List<SuraEntity> surahs = await repo.getAllSuras();
    return surahs;
  }

  String normalizeArabicText(String text) {
    return text
        .replaceAll('ٱ', 'ا')
        .replaceAll('إ', 'ا')
        .replaceAll('أ', 'ا')
        .replaceAll('آ', 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ؤ', 'و')
        .replaceAll('ً', '')
        .replaceAll('ٌ', '')
        .replaceAll('ٍ', '')
        .replaceAll('َ', '')
        .replaceAll('ُ', '')
        .replaceAll('ِ', '')
        .replaceAll('ّ', '')
        .replaceAll('ْ', '')
        .replaceAll('ٓ', '')
        .replaceAll('ٔ', '')
        .replaceAll('ٕ', '')
        .replaceAll('ٖ', '')
        .replaceAll('ٗ', '')
        .replaceAll('٘', '')
        .replaceAll('ٙ', '')
        .replaceAll('ٚ', '')
        .replaceAll('ٛ', '')
        .replaceAll('ٜ', '')
        .replaceAll('ٝ', '')
        .replaceAll('ٞ', '')
        .replaceAll('ٟ', '');
  }

  search({required String query}) async {
    emit(SearchLoadingState());
    if (query.isEmpty) {
      emit(SearchInitialState());
    } else if (query.isNotEmpty) {
      List<SuraEntity> allSurahs = await getAllSurahs();
      if (isInt(query) && toInt(query) < 605 && toInt(query) > 0) {
        List<SuraEntity> searchResults = allSurahs.where(
          (element) {
            return element.number == toInt(query);
          },
        ).toList();
        emit(
          SearchByNumberSuccessState(
            number: toInt(query),
            searchResults: searchResults,
          ),
        );
      } else if (query.length >= 3) {
        List<SuraEntity> searchResults = allSurahs.where(
          (element) {
            return removeDiacritics(normalizeArabicText(element.name))
                .contains(query);
          },
        ).toList();
        var searchedAyah = searchWords(query);
        //log('searched : '+searchedAyah.toString());
        var result = searchedAyah['result'];
        if (searchedAyah['occurences'] > 15) {
          result = result.sublist(0, 15);
        }
        List<dynamic> ayahs = result.map(
          (e) {
            return AyahEntity(
              surahNumber: e['surah'],
              ayahNumber: e['verse'],
              ayah: getVerse(e['surah'], e['verse']),
              suraName: allSurahs
                  .firstWhere((element) => element.number == e['surah'])
                  .name,
            );
          },
        ).toList();
        emit(SearchSuccessState(searchResults: searchResults, ayahs: ayahs));
      }
    }
  }
}
