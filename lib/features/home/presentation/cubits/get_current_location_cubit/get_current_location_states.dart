import 'package:geolocator/geolocator.dart';

abstract class GetCurrentLocationState{}

class GetCurrentLocationInitial extends GetCurrentLocationState{}

class GetCurrentLocationLoading extends GetCurrentLocationState{}

class GetCurrentLocationSuccess extends GetCurrentLocationState{
  final Position position;
  final String address;

  GetCurrentLocationSuccess({required this.position, required this.address});
}

class GetCurrentLocationFailed extends GetCurrentLocationState{
  final String message;

  GetCurrentLocationFailed({required this.message});
}