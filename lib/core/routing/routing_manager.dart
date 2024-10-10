import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/widgets/manager_view.dart';
import 'package:mo3een/core/managers/di.dart';
import 'package:mo3een/core/routing/custom_page_route.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:mo3een/features/quran/presentation/cubits/search_tabs_cubit/search_tabs_cubit.dart';
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
      default:
        return null;
    }
  }
}
