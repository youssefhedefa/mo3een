import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/widgets/manager_view.dart';
import 'package:mo3een/core/managers/di.dart';
import 'package:mo3een/core/routing/custom_page_route.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/azkar/data/model/zekr_item_model.dart';
import 'package:mo3een/features/azkar/presentation/cubits/zekr_counter_cubit/zekr_counter_cubit.dart';
import 'package:mo3een/features/azkar/presentation/ui/azkar_data.dart';
import 'package:mo3een/features/on_boarding/presentation/on_boarding_view.dart';
import 'package:mo3een/features/qibla/presentation/ui/qibla_view.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';
import 'package:mo3een/features/quran/presentation/cubits/get_mark_cubit/get_mark_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_tabs_cubit/search_tabs_cubit.dart';
import 'package:mo3een/features/quran/presentation/quran_page.dart';
import 'package:mo3een/features/quran/presentation/search_view.dart';
import 'package:mo3een/features/sep7a/data/models/sep7a_model.dart';
import 'package:mo3een/features/sep7a/presentation/ui/sep7a_counter.dart';

class AppRoutingManager {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutingConstances.onBourding:
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: const OnBoardingView(),
        );
      case AppRoutingConstances.home:
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: const ManagerView(),
        );
      case AppRoutingConstances.search:
        return CustomPageRoute(
          axisDirection: AxisDirection.up,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<SearchCubit>()),
              BlocProvider(
                create: (context) => SearchTabsCubit()..initialSearchType(),
              ),
            ],
            child: const SearchView(),
          ),
        );
      case AppRoutingConstances.quranPage:
        final page = settings.arguments as QuranPageModel;
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: BlocProvider(
            create: (context) => GetMarkCubit(),
            child: QuranPage(page: page),
          ),
        );
      case AppRoutingConstances.zekrPage:
        final zekr = settings.arguments as ZekrItemModel;
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: BlocProvider(
            create: (context) => ZekrCounterCubit(),
            child: AzkarDataView(zekr: zekr),
          ),
        );
      case AppRoutingConstances.sep7aCounter:
        final zkr = settings.arguments as Sep7aZekrModel;
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: Sep7aCounter(zkr: zkr),
        );
      case AppRoutingConstances.qiblaPage:
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: const QiblaView(),
        );
      default:
        return null;
    }
  }
}
