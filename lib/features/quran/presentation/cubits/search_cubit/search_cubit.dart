import 'dart:developer';
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
  FocusNode searchFocusNode = FocusNode();
  Future<List<SuraEntity>> getAllSurahs() async {
    List<SuraEntity> surahs = await repo.getAllSuras();
    return surahs;
  }

  String normalizeArabicText(String text) {
    RegExp arabicFormation = RegExp(
        r'[\u0610-\u061A\u064B-\u065F\u06D6-\u06DC\u06DF-\u06E8\u06EA-\u06ED]');
    final cleanText = text.replaceAll(arabicFormation, '');
    return cleanText
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
        .replaceAll('ٌ', '')
        .replaceAll('ُ', '')
        .replaceAll('ً', '')
        .replaceAll('ً', '')
        .replaceAll('َ', '')
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
      } else if (query.length >= 2) {
        emit(
          SearchSuccessState(
            searchResults: _searchOnSuras(
              query: query,
              allSurahs: allSurahs,
            ),
            ayahs: _searchOnAyahs(
              query: query,
              allSurahs: allSurahs,
            ),
          ),
        );
      }
    }
  }

  List<SuraEntity> _searchOnSuras(
      {required String query, required List<SuraEntity> allSurahs}) {
    List<SuraEntity> searchResults = allSurahs.where(
      (element) {
        return removeDiacritics(normalizeArabicText(element.name))
            .contains(query);
      },
    ).toList();
    return searchResults;
  }

  List<dynamic> _searchOnAyahs(
      {required String query, required List<SuraEntity> allSurahs}) {
    var searchedAyah = searchWords(query);
    var result = searchedAyah['result'];
    if (searchedAyah['occurences'] > 15) {
      result = result.sublist(0, 15);
    }
    List<dynamic> ayahs = result.map(
      (aya) {
        log('aya: ${getVerse(aya['surah'], aya['verse'])}');
        return AyahEntity(
          surahNumber: aya['surah'],
          ayahNumber: aya['verse'],
          ayah: getVerse(aya['surah'], aya['verse']),
          suraName: allSurahs
              .firstWhere((element) => element.number == aya['surah'])
              .name,
        );
      },
    ).toList();
    return ayahs;
  }
}
