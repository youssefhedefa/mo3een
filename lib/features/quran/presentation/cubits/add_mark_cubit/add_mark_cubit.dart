import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/quran/data/models/quran_mark_model.dart';
import 'package:mo3een/features/quran/presentation/cubits/add_mark_cubit/add_mark_states.dart';

class AddMarkCubit extends Cubit<AddMarkState> {
  AddMarkCubit() : super(AddMarkInitialState());

  addMark({required QuranMarkModel mark}) async{
    emit(AddMarkLoadingState());
    try {
      var box = Hive.box<QuranMarkModel>(AppBoxConstants.quranMarksBox);
      await box.add(mark);
      emit(AddMarkSuccessState());
    } catch (e) {
      log(e.toString());
      emit(AddMarkErrorState(e.toString()));
    }
  }
}
