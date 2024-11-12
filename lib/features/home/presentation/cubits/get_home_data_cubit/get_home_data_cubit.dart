import 'package:bloc/bloc.dart';
import 'package:mo3een/features/home/data/repo/home_repo.dart';
import 'package:mo3een/features/home/presentation/cubits/get_home_data_cubit/get_home_data_state.dart';

class GetHomeDataCubit extends Cubit<GetHomeDataState> {
  GetHomeDataCubit({required this.repo}) : super(GetHomeDataInitialState());

  final HomeRepo repo;

  getHomeData({bool? refresh}) async {
    emit(GetHomeDataLoadingState());
    final dataResponse = await repo.getHomeData(
      refresh: refresh ?? false,
    );
    dataResponse.fold(
      (error) => emit(GetHomeDataErrorState(error: error)),
      (data) => emit(GetHomeDataSuccessState(data: data)),
    );
  }
}
