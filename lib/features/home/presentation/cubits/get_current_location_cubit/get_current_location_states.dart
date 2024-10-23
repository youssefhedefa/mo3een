import 'package:mo3een/core/components/models/current_postion.dart';

abstract class GetCurrentLocationState{}

class GetCurrentLocationInitial extends GetCurrentLocationState{}

class GetCurrentLocationLoading extends GetCurrentLocationState{}

class GetCurrentLocationSuccess extends GetCurrentLocationState{
  // final Position position;
  // final String address;

  final CurrentPosition position;

  GetCurrentLocationSuccess({required this.position});
}

class GetCurrentLocationFailed extends GetCurrentLocationState{
  final String message;

  GetCurrentLocationFailed({required this.message});
}