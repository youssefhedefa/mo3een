import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/sep7a/data/models/sep7a_model.dart';
import 'package:mo3een/features/sep7a/presentation/cubit/get_sep7a_azkar_cubit/get_sep7a_azkar_states.dart';

class GetSep7aAzkarCubit extends Cubit<GetSep7aAzkarState>{
  GetSep7aAzkarCubit():super(GetSep7aAzkarInitialState());

  getSep7aAzkar() async{
    emit(GetSep7aAzkarLoadingState());
    try{
      var box = await Hive.openBox<Sep7aZekrModel>(AppBoxConstants.sep7aZekrBox);
      List<Sep7aZekrModel> azkar = box.values.toList();
      azkar = AppConstants.initialSep7aAzkar + azkar;
      log(azkar.length.toString());
      emit(GetSep7aAzkarSuccessState(azkar: azkar));
    }catch(e){
      emit(GetSep7aAzkarErrorState(error: e.toString()));
    }
  }

}