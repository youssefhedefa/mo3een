import 'package:mo3een/features/azkar/data/model/azkar_model.dart';

abstract class GetAllSavedAzkarState{}

class GetAllSavedAzkarInitialState extends GetAllSavedAzkarState{}

class GetAllSavedAzkarLoadingState extends GetAllSavedAzkarState{}

class GetAllSavedAzkarSuccessState extends GetAllSavedAzkarState{
  final List<AzkarModel> azkarList;

  GetAllSavedAzkarSuccessState({required this.azkarList});
}

class GetAllSavedAzkarErrorState extends GetAllSavedAzkarState{
  final String message;

  GetAllSavedAzkarErrorState({required this.message});
}