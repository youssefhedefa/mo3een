abstract class GetDateStates{}


class GetDateInitialState extends GetDateStates{}

class GetDateLoadingState extends GetDateStates{}

class GetDateSuccessState extends GetDateStates{
  final String pickedDate;
  GetDateSuccessState({required this.pickedDate});
}

class GetDateErrorState extends GetDateStates{
  final String error;
  GetDateErrorState({required this.error});
}