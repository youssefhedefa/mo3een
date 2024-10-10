import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_item.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: CustomTabItem(
            title: AppConstants.testTabItemList[index],
            isSelected: selectedIndex == index,
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 8,),
        itemCount: 4,
      ),
    );
  }
}
