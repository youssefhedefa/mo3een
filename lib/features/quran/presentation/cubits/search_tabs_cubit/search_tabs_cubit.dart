import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_tabs_cubit/search_tabs_states.dart';

class SearchTabsCubit extends Cubit<SearchTabsStates> {
  SearchTabsCubit() : super(SearchBySurah());

  initialSearchType(){
    emit(SearchBySurah());
  }

  searchType({required SearchType type,required BuildContext context}){
    if(type == SearchType.SurahType){
      emit(SearchBySurah());
    }
    else if(type == SearchType.AyahType){
      emit(SearchByAyah());
    }
  }

}
enum SearchType {
  SurahType,
  AyahType,
}
