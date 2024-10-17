abstract class AddSep7aZekrState{}

class AddSep7aZekrInitialState extends AddSep7aZekrState{}

class AddSep7aZekrLoadingState extends AddSep7aZekrState{}

class AddSep7aZekrSuccessState extends AddSep7aZekrState{}

class AddSep7aZekrErrorState extends AddSep7aZekrState{
  final String error;
  AddSep7aZekrErrorState({required this.error});
}