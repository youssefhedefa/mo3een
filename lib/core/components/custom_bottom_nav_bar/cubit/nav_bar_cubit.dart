import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/custom_bottom_nav_bar/cubit/nav_bar_states.dart';
import 'package:mo3een/core/components/models/bottom_nav_bar_item_model.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/managers/di.dart';
import 'package:mo3een/features/azkar/presentation/cubits/add_zekr_to_saved_cubit/add_zekr_to_saved_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/azkar_tabs_cubit/azkar_tabs_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/delete_zekr_from_saved_cubit/delete_zekr_from_saved_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_azkar_cubit/get_all_azkar_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/get_all_saved_azkar_cubit/get_all_saved_azkar_cubit.dart';
import 'package:mo3een/features/azkar/presentation/cubits/search_for_zekr_cubit/search_for_zekr_cubit.dart';
import 'package:mo3een/features/azkar/presentation/ui/azkar_view.dart';
import 'package:mo3een/features/home/presentation/cubits/get_date_cubit/get_date_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:mo3een/features/home/presentation/cubits/get_random_verse_cubit/get_random_verse_cubit.dart';
import 'package:mo3een/features/home/presentation/home.dart';
import 'package:mo3een/features/qibla/presentation/ui/qibla_view.dart';
import 'package:mo3een/features/quran/presentation/cubits/add_mark_cubit/add_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_all_surahs_cubit/get_all_surahs_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/quran_tabs_cubit/quran_tabs_cubit.dart';
import 'package:mo3een/features/quran/presentation/quran_view.dart';
import 'package:mo3een/features/sep7a/presentation/cubit/get_sep7a_azkar_cubit/get_sep7a_azkar_cubit.dart';
import 'package:mo3een/features/sep7a/presentation/ui/sep7a_view.dart';

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
      title: 'المزيد',
      icon: AppIconHelper.moreIcon,
      isSelected: false,
    ),
  ];

  List<Widget> screens =[
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetDateCubit()..getInitialDate()),
        BlocProvider(create: (context) => getIt<GetHomeDataCubit>()..getHomeData()),
        BlocProvider(create: (context) => GetRandomVerseCubit()..getRandomVerseCall()),
      ],
      child: const HomeView(),
      //child: const HomeViewTest(),
    ),
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<GetAllSurahsCubit>()..getAllSurahs()),
          BlocProvider(create: (context) => QuranTabsCubit(),),
          BlocProvider(create: (context) => AddMarkCubit(),),
          BlocProvider(create: (context) => GetMarkCubit()..getMark(),),
        ],
        child: const QuranView(),),
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AzkarTabsCubit()),
        BlocProvider(create: (context) => SearchForZekrCubit()),
        BlocProvider(create: (context) => GetAllAzkarCubit()..getAllAzkar()),
        BlocProvider(create: (context) => AddZekrToSavedCubit()),
        BlocProvider(create: (context) => DeleteZekrFromSavedCubit()),
        BlocProvider(create: (context) => GetAllSavedAzkarCubit()..getAllSavedAzkar()),
      ],
        child: const AzkarView(),
    ),
    BlocProvider(
      create: (context) => GetSep7aAzkarCubit()..getSep7aAzkar(),
        child: const Sep7aView(),
    ),
    const QiblaView(),
  ];

  void changeNavBarItem(int index){
    emit(BottomNavBarChangeIndexState(
      index: index,
      view: screens[index],
    ));
  }

}