import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo3een/core/components/custom_bottom_nav_bar/cubit/nav_bar_cubit.dart';
import 'package:mo3een/core/components/custom_bottom_nav_bar/cubit/nav_bar_states.dart';
import 'package:mo3een/core/components/custom_bottom_nav_bar/ui/custom_bottom_nav_bar.dart';

class ManagerView extends StatelessWidget {
  const ManagerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit()..changeNavBarItem(0),
      child: Builder(
        builder: (context) {
          return BlocBuilder<BottomNavBarCubit, BottomNavBarStates>(
            builder: (context, state) {
              if (state is BottomNavBarChangeIndexState) {
                return Scaffold(
                  bottomNavigationBar:
                      CustomBottomNavBar(currentIndex: state.index),
                  body: state.view,
                );
              }
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}
