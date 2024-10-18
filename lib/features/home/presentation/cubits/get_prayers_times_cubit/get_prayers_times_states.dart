import 'package:mo3een/features/home/data/models/prayer_model.dart';

abstract class GetPrayersTimesState{}

class GetPrayersTimesInitialState extends GetPrayersTimesState{}

class GetPrayersTimesLoadingState extends GetPrayersTimesState{}

class GetPrayersTimesSuccessState extends GetPrayersTimesState{
  final List<PrayerModel> prayers;

  GetPrayersTimesSuccessState({required this.prayers});
}

class GetPrayersTimesErrorState extends GetPrayersTimesState{
  final String error;

  GetPrayersTimesErrorState({required this.error});
}