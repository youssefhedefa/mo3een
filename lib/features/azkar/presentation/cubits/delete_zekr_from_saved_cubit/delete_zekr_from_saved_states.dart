abstract class DeleteZekrFromSavedState{}

class DeleteZekrFromSavedInitialState extends DeleteZekrFromSavedState{}

class DeleteZekrFromSavedLoadingState extends DeleteZekrFromSavedState{}

class DeleteZekrFromSavedSuccessState extends DeleteZekrFromSavedState{}

class DeleteZekrFromSavedErrorState extends DeleteZekrFromSavedState{
  final String error;
  DeleteZekrFromSavedErrorState({required this.error});
}