import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/components/custom_bottom_nav_bar/cubit/nav_bar_cubit.dart';
import 'package:mo3een/core/components/custom_bottom_nav_bar/cubit/nav_bar_states.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit()..changeNavBarItem(0),
      child: Builder(builder: (context) {
        return BlocBuilder<BottomNavBarCubit, BottomNavBarStates>(
            builder: (context, state) {
          if (state is BottomNavBarChangeIndexState) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: state.index,
                onTap: (index) {
                  context.read<BottomNavBarCubit>().changeNavBarItem(index);
                },
                showSelectedLabels: true,
                showUnselectedLabels: true,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: AppTextStyleHelper.font10BoldPrimary,
                unselectedLabelStyle:
                    AppTextStyleHelper.font10RegularLightPrimary,
                unselectedItemColor: AppColorHelper.lightPrimaryColor,
                items: _buildBottomNavBarItems(
                  currentIndex: state.index,
                  context: context,
                ),
              ),
              body: state.view,
            );
          }
          return const SizedBox();
        });
      }),
    );
  }

  BottomNavigationBarItem _buildBottomNavBarItem({
    required String icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          isSelected
              ? AppColorHelper.primaryColor
              : AppColorHelper.lightPrimaryColor,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavBarItems(
      {required int currentIndex, required BuildContext context}) {
    return context.read<BottomNavBarCubit>().bottomNavBarItems.map(
      (item) {
        return _buildBottomNavBarItem(
          icon: item.icon,
          label: item.title,
          isSelected: currentIndex ==
              context.read<BottomNavBarCubit>().bottomNavBarItems.indexOf(item),
        );
      },
    ).toList();
  }

}
