import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/sep7a/data/models/sep7a_model.dart';
import 'package:mo3een/features/sep7a/presentation/cubit/add_sep7a_zekr_cubit/add_sep7a_zekr_states.dart';

class AddSep7aZekrCubit extends Cubit<AddSep7aZekrState>{
  AddSep7aZekrCubit() : super(AddSep7aZekrInitialState());

  TextEditingController titleController = TextEditingController();
  TextEditingController countController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  addSep7aZekr({required Sep7aZekrModel zekr}) async {
    emit(AddSep7aZekrLoadingState());
    try {
      var box = Hive.box<Sep7aZekrModel>(AppBoxConstants.sep7aZekrBox);
      await box.add(zekr);
      emit(AddSep7aZekrSuccessState());
    } catch (e) {
      emit(AddSep7aZekrErrorState(error: e.toString()));
    }
  }
}