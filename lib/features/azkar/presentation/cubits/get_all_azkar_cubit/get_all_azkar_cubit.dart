import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/features/azkar/data/azkar_data/azkar.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_azkar_cubit/get_all_azkar_states.dart';

class GetAllAzkarCubit extends Cubit<GetAllAzkarState> {

  GetAllAzkarCubit() : super(GetAllAzkarInitialState());

  getAllAzkar() async {
    emit(GetAllAzkarLoadingState());
    try {
      var allAzkar = azkar.map((e) => AzkarModel.fromJson(e)).toList();
      emit(GetAllAzkarSuccessState(azkar: allAzkar));
    } catch (e) {
      emit(GetAllAzkarErrorState(message: e.toString()));
    }
  }
}