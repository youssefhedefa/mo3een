abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  final dynamic searchResults;
  final dynamic ayahs;

  SearchSuccessState({required this.searchResults,required this.ayahs});
}

class SearchByNumberSuccessState extends SearchStates {
  final dynamic searchResults;
  final num number;

  SearchByNumberSuccessState({
    required this.number,
    required this.searchResults,
  });
}

class SearchErrorState extends SearchStates {
  final String message;

  SearchErrorState({required this.message});
}


