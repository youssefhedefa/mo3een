abstract class AddZekrToSavedState{}

class AddZekrToSavedInitialState extends AddZekrToSavedState{}

class AddZekrToSavedLoadingState extends AddZekrToSavedState{}

class AddZekrToSavedSuccessState extends AddZekrToSavedState{}

class AddZekrToSavedErrorState extends AddZekrToSavedState{
  final String message;

  AddZekrToSavedErrorState({required this.message});
}