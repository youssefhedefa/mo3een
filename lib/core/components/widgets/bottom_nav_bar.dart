import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/components/models/bottom_nav_bar_item_model.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({Key? key}) : super(key: key);

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: AppTextStyleHelper.font10BoldPrimary,
      unselectedLabelStyle: AppTextStyleHelper.font10RegularLightPrimary,
      unselectedItemColor: AppColorHelper.lightPrimaryColor,
      items: _buildBottomNavBarItems(
        currentIndex: _selectedIndex,
      ),
    );
  }

  List<BottomNavBarItemModel> items = [
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
      {required int currentIndex}) {
    return items.map(
      (item) {
        return _buildBottomNavBarItem(
          icon: item.icon,
          label: item.title,
          isSelected: currentIndex == items.indexOf(item),
        );
      },
    ).toList();
  }

}
