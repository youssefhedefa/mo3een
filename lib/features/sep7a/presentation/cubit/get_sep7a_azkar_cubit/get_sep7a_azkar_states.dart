import 'package:mo3een/features/sep7a/data/models/sep7a_model.dart';

abstract class GetSep7aAzkarState{}

class GetSep7aAzkarInitialState extends GetSep7aAzkarState{}

class GetSep7aAzkarLoadingState extends GetSep7aAzkarState{}

class GetSep7aAzkarSuccessState extends GetSep7aAzkarState{
  final List<Sep7aZekrModel> azkar;

  GetSep7aAzkarSuccessState({required this.azkar});
}

class GetSep7aAzkarErrorState extends GetSep7aAzkarState{
  final String error;

  GetSep7aAzkarErrorState({required this.error});
}