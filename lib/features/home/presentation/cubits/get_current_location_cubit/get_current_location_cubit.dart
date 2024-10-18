import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mo3een/core/helpers/get_current_position_helper.dart';
import 'package:mo3een/features/home/presentation/cubits/get_current_location_cubit/get_current_location_states.dart';

class GetCurrentLocationCubit extends Cubit<GetCurrentLocationState>{
  GetCurrentLocationCubit() : super(GetCurrentLocationInitial());

  getLocation()async{
    emit(GetCurrentLocationLoading());
    try{
      final position = await LocationHelper.getCurrentPosition();
      final address = await LocationHelper.getAddressFromLatLng(position);
      log("address $address");
      if(address == null){
        emit(GetCurrentLocationFailed(message: "Failed to get address"));
        return;
      }
      emit(GetCurrentLocationSuccess(position: position, address: address));
    }catch(e){
      emit(GetCurrentLocationFailed(message: e.toString()));
    }
  }
}