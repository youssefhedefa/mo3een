import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:mo3een/features/home/data/repo/home_repo.dart';
import 'package:mo3een/features/home/presentation/cubits/get_current_location_cubit/get_current_location_states.dart';

class GetCurrentLocationCubit extends Cubit<GetCurrentLocationState> {
  final HomeRepo repo;
  GetCurrentLocationCubit({required this.repo})
      : super(GetCurrentLocationInitial());

  getLocation() async {
    try {
      final position = await repo.getCurrentPosition();
      //final address = await repo.getCurrentLocation();
      log("address from cubit $position");
      emit(
        GetCurrentLocationSuccess(position: position),
      );
    } catch (e) {
      log('from location-------------------------'+e.toString());
      emit(GetCurrentLocationFailed(message: e.toString()));
    }
  }
}
