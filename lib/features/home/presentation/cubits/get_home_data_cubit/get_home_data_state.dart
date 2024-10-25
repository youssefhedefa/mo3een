import 'package:mo3een/features/home/data/models/home_data_model.dart';

abstract class GetHomeDataState {}

class GetHomeDataInitialState extends GetHomeDataState {}

class GetHomeDataLoadingState extends GetHomeDataState {}

class GetHomeDataSuccessState extends GetHomeDataState {
  final HomeDataModel data;

  GetHomeDataSuccessState({required this.data});
}

class GetHomeDataErrorState extends GetHomeDataState {
  final String error;

  GetHomeDataErrorState({required this.error});
}