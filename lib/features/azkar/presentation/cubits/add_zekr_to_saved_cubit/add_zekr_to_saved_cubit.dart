import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/azkar/presentation/cubits/add_zekr_to_saved_cubit/add_zekr_to_saved_states.dart';

class AddZekrToSavedCubit extends Cubit<AddZekrToSavedState>{
  AddZekrToSavedCubit():super(AddZekrToSavedInitialState());

  Future<void> addToSaved({required AzkarModel zekr}) async{
    emit(AddZekrToSavedLoadingState());
    try{
      var savedBox = Hive.box<AzkarModel>(AppBoxConstants.azkarBox);
      savedBox.add(zekr);
      emit(AddZekrToSavedSuccessState());
    }catch(e){
      emit(AddZekrToSavedErrorState(message: e.toString()));
    }
  }

}