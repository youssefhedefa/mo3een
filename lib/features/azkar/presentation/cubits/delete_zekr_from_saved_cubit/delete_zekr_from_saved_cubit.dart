import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/azkar/presentation/cubits/delete_zekr_from_saved_cubit/delete_zekr_from_saved_states.dart';

class DeleteZekrFromSavedCubit extends Cubit<DeleteZekrFromSavedState> {

  DeleteZekrFromSavedCubit() : super(DeleteZekrFromSavedInitialState());

  Future<void> deleteZekrFromSaved({required AzkarModel zekr}) async {
    emit(DeleteZekrFromSavedLoadingState());
    try {
      var box = Hive.box<AzkarModel>(AppBoxConstants.azkarBox);
      await box.delete(zekr.key);
      emit(DeleteZekrFromSavedSuccessState());
    } catch (e) {
      emit(DeleteZekrFromSavedErrorState(error: e.toString()));
    }
  }
}