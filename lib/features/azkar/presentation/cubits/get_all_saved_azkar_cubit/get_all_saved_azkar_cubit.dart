import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_saved_azkar_cubit/get_all_saved_azkar_states.dart';

class GetAllSavedAzkarCubit extends Cubit<GetAllSavedAzkarState> {
  GetAllSavedAzkarCubit() : super(GetAllSavedAzkarInitialState());

  Future<void> getAllSavedAzkar() async {
    emit(GetAllSavedAzkarLoadingState());
    try {
      var savedBox = Hive.box<AzkarModel>(AppBoxConstants.azkarBox);
      List<AzkarModel> azkarList = savedBox.values.toList();
      emit(GetAllSavedAzkarSuccessState(azkarList: azkarList));
    } catch (e) {
      emit(GetAllSavedAzkarErrorState(message: e.toString()));
    }
  }
}