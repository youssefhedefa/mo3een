import 'package:mo3een/features/quran/data/models/quran_mark_model.dart';

abstract class GetMarkStates{}

class GetMarkInitialState extends GetMarkStates{}

class GetMarkLoadingState extends GetMarkStates{}

class GetMarkSuccessState extends GetMarkStates{
  final QuranMarkModel mark;

  GetMarkSuccessState({required this.mark});
}

class GetMarkErrorState extends GetMarkStates{
  final String message;

  GetMarkErrorState({required this.message});
}