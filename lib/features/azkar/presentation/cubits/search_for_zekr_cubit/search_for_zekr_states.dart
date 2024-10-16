import 'package:mo3een/features/azkar/data/model/azkar_model.dart';

abstract class SearchForZekrState{}

class SearchForZekrInitialState extends SearchForZekrState{}

class SearchForZekrLoadingState extends SearchForZekrState{}

class SearchForZekrSuccessState extends SearchForZekrState{
  final List<AzkarModel> azkar;

  SearchForZekrSuccessState({required this.azkar});
}

class SearchForZekrErrorState extends SearchForZekrState{
  final String message;

  SearchForZekrErrorState({required this.message});
}