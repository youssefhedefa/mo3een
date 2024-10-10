import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';
import 'package:mo3een/features/quran/domain/repo/quran_repo.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_all_surahs_cubit/get_all_surahs_states.dart';

class GetAllSurahsCubit extends Cubit<GetAllSurahsStates>{
  GetAllSurahsCubit({required this.repo}) : super(GetAllSurahsInitialState());
  final QuranRepo repo;

  getAllSurahs() async {
    emit(GetAllSurahsLoadingState());
    try {
      final List<SuraEntity> surahs = await repo.getAllSuras();
      emit(GetAllSurahsSuccessState(surahs: surahs));
    } catch (e) {
      emit(GetAllSurahsErrorState(message: e.toString()));
    }
  }
}