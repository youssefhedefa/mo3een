import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/quran/presentation/cubits/quran_tabs_cubit/quran_tabs_states.dart';

class QuranTabsCubit extends Cubit<QuranTabsState> {
  QuranTabsCubit() : super(QuranBySurahState());


  changeQuranTap({required QuranTabs tab}){
    switch(tab){
      case QuranTabs.Surah:
        emit(QuranBySurahState());
        break;
      case QuranTabs.Juz:
        emit(QuranByJuzState());
        break;
      case QuranTabs.Page:
        emit(QuranByPageState());
        break;
    }
  }

}

enum QuranTabs { Surah, Juz, Page }