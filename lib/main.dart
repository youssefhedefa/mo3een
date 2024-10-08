import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/utilities/bloc_observer.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/mo3een_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  changeSystemUiOverlayStyle();
  Bloc.observer = MyBlocObserver();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
  ]);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar')],
      path: AppConstants.translationPath,
      fallbackLocale: const Locale('ar'),
      child: const Mo3eenApp(),
    ),
  );
}

changeSystemUiOverlayStyle(){
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );
}