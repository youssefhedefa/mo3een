import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/utilities/bloc_observer.dart';
import 'package:mo3een/mo3een_app.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const Mo3eenApp());
}
