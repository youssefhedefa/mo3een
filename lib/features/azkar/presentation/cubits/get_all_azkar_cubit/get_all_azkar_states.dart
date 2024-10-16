import 'package:mo3een/features/azkar/data/model/azkar_model.dart';

abstract class GetAllAzkarState{}

class GetAllAzkarInitialState extends GetAllAzkarState{}

class GetAllAzkarLoadingState extends GetAllAzkarState{}

class GetAllAzkarSuccessState extends GetAllAzkarState{
  final List<AzkarModel> azkar;

  GetAllAzkarSuccessState({required this.azkar});
}

class GetAllAzkarErrorState extends GetAllAzkarState{
  final String message;

  GetAllAzkarErrorState({required this.message});
}
