import 'package:flutter/material.dart';

abstract class BottomNavBarStates {}

class BottomNavBarInitialState extends BottomNavBarStates {}

class BottomNavBarChangeIndexState extends BottomNavBarStates {
  final int index;
  final Widget view;
  BottomNavBarChangeIndexState({required this.index, required this.view});
}
