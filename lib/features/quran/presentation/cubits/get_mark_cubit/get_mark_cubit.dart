import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/quran/data/models/quran_mark_model.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_states.dart';

class GetMarkCubit extends Cubit<GetMarkStates> {
  GetMarkCubit() : super(GetMarkInitialState());

  getMark() {
    log('is called');
    emit(GetMarkLoadingState());
    try {
      var box = Hive.box<QuranMarkModel>(AppBoxConstants.quranMarksBox);
      var mark = box.get(0) ??
          QuranMarkModel(
            id: 0,
            ayah: 1,
            page: 1,
            surah: 1,
          );
      log('from get $mark');
      emit(GetMarkSuccessState(mark: mark));
    } catch (e) {
      log('from get mark $e');
      emit(GetMarkErrorState(message: e.toString()));
    }
  }
}
