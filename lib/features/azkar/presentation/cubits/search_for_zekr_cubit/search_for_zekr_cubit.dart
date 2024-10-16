import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/azkar/data/azkar_data/azkar.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/azkar/presentation/cubits/search_for_zekr_cubit/search_for_zekr_states.dart';

class SearchForZekrCubit extends Cubit<SearchForZekrState> {
  SearchForZekrCubit() : super(SearchForZekrInitialState());

  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();


  emitInitialState(){
    emit(SearchForZekrInitialState());
  }

  searchForZekr({required String searchValue}) async {
    emit(SearchForZekrLoadingState());
    try {
      var allAzkar = azkar.map((e) => AzkarModel.fromJson(e)).toList();
      var searchResult = allAzkar
          .where((element) =>
              element.category.toLowerCase().contains(searchValue.toLowerCase()))
          .toList();
      emit(SearchForZekrSuccessState(azkar: searchResult));
    } catch (e) {
      emit(SearchForZekrErrorState(message: e.toString()));
    }
  }
}