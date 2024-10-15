import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';

abstract class GetAllSurahsStates{}

class GetAllSurahsInitialState extends GetAllSurahsStates{}

class GetAllSurahsLoadingState extends GetAllSurahsStates{}

class GetAllSurahsSuccessState extends GetAllSurahsStates{
  final List<SuraEntity> surahs;

  GetAllSurahsSuccessState({required this.surahs});
}

class GetAllSurahsErrorState extends GetAllSurahsStates{
  final String message;

  GetAllSurahsErrorState({required this.message});
}

