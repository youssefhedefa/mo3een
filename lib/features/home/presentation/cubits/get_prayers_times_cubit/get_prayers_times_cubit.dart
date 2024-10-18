import 'package:bloc/bloc.dart';
import 'package:mo3een/features/home/data/repo/home_repo.dart';
import 'package:mo3een/features/home/presentation/cubits/get_prayers_times_cubit/get_prayers_times_states.dart';

class GetPrayersTimesCubit extends Cubit<GetPrayersTimesState>{
  final HomeRepo repo;
  GetPrayersTimesCubit({required this.repo}):super(GetPrayersTimesInitialState());

  getTimes({required num lat,required num lon}) async{
    emit(GetPrayersTimesLoadingState());
    final response = await repo.getPrayerTimes(latitude: lat, longitude: lon);
    response.fold((prayers) {
      emit(GetPrayersTimesSuccessState(prayers: prayers));
    }, (error) {
      emit(GetPrayersTimesErrorState(error: error));
    });

  }


}