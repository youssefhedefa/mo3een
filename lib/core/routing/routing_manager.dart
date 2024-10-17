import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/widgets/manager_view.dart';
import 'package:mo3een/core/managers/di.dart';
import 'package:mo3een/core/routing/custom_page_route.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/azkar/data/model/zekr_item_model.dart';
import 'package:mo3een/features/azkar/presentation/ui/azkar_data.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_tabs_cubit/search_tabs_cubit.dart';
import 'package:mo3een/features/quran/presentation/quran_page.dart';
import 'package:mo3een/features/quran/presentation/search_view.dart';

class AppRoutingManager {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutingConstances.home:
        return CustomPageRoute(
          axisDirection: AxisDirection.up,
          child: const ManagerView(),
        );
      case AppRoutingConstances.search:
        return CustomPageRoute(
          axisDirection: AxisDirection.up,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<SearchCubit>(),
              ),
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
          child: QuranPage(page: page),
        );
      case AppRoutingConstances.zekrPage:
        final zekr = settings.arguments as ZekrItemModel;
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: AzkarDataView(
            zekr: zekr,
          ),
        );
      default:
        return null;
    }
  }
}
