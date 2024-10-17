import 'package:mo3een/features/home/data/models/quran_verse.dart';

abstract class GetRandomVerseState{}

class GetRandomVerseInitialState extends GetRandomVerseState{}

class GetRandomVerseLoadingState extends GetRandomVerseState{}

class GetRandomVerseLoadedState extends GetRandomVerseState{
  final QuranVerse verse;

  GetRandomVerseLoadedState({required this.verse});
}

class GetRandomVerseErrorState extends GetRandomVerseState{
  final String message;

  GetRandomVerseErrorState({required this.message});
}

