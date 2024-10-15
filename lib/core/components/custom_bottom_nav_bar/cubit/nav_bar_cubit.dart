import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/custom_bottom_nav_bar/cubit/nav_bar_states.dart';
import 'package:mo3een/core/components/models/bottom_nav_bar_item_model.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/managers/di.dart';
import 'package:mo3een/features/home/presentation/cubits/get_date/get_date_cubit.dart';
import 'package:mo3een/features/home/presentation/home.dart';
import 'package:mo3een/features/quran/presentation/cubits/add_mark_cubit/add_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_all_surahs_cubit/get_all_surahs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/quran_tabs_cubit/quran_tabs_cubit.dart';
import 'package:mo3een/features/quran/presentation/quran_view.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarStates>{
  BottomNavBarCubit() : super(BottomNavBarInitialState());

  List<BottomNavBarItemModel> bottomNavBarItems = [
    BottomNavBarItemModel(
      title: 'الرئيسية',
      icon: AppIconHelper.homeIcon,
      isSelected: true,
    ),
    BottomNavBarItemModel(
      title: 'القرآن الكريم',
      icon: AppIconHelper.quranIcon,
      isSelected: false,
    ),
    BottomNavBarItemModel(
      title: 'الأذكار',
      icon: AppIconHelper.azkarIcon,
      isSelected: false,
    ),
    BottomNavBarItemModel(
      title: 'السبحة',
      icon: AppIconHelper.sep7aIcon,
      isSelected: false,
    ),
    BottomNavBarItemModel(
      title: 'قبلة الصلاة',
      icon: AppIconHelper.qeplaIcon,
      isSelected: false,
    ),
  ];

  List<Widget> screens =[
    BlocProvider(
      create: (context) => GetDateCubit()..getInitialDate(),
        child: const HomeView(),
    ),
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<GetAllSurahsCubit>()..getAllSurahs()),
          BlocProvider(create: (context) => QuranTabsCubit(),),
          BlocProvider(create: (context) => AddMarkCubit(),),
        ],
        child: const QuranView(),),
    Scaffold(body: Container(color: Colors.blue,),),
    Scaffold(body: Container(color: Colors.yellow,),),
    Scaffold(body: Container(color: Colors.purple,),),
  ];


  void changeNavBarItem(int index){
    emit(BottomNavBarChangeIndexState(
      index: index,
      view: screens[index],
    ));
  }

}