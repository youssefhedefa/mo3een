import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:mo3een/core/helpers/image_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/core/utilities/box_constants.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/add_sep7a_zekr_button.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final List<String> _images = [
    AppImageHelper.onBoarding1Image,
    AppImageHelper.onBoarding2Image,
    AppImageHelper.onBoarding3Image,
  ];

  final List<String> titles = [
    ' تطبيق مُعيِن ',
    'السبحة الالكترونية ',
    'تحديد موقعك',
  ];

  final List<String> descriptions = [
    'يحتوي تطبيق مُعيِن على المصحف الشريف وخاصية مواقيت الصلاة والادعية والأذكار وتحديد اتجاه القبلة وغيرها ...',
    'يوجد ميزة السبحة الالكترونية للتسبيح ويمكنك اضافة الاذكار الخاصة بك',
    'يتم استخدام الموقع الجغرافي الخاص بك حتى يتم تحديد مواقيت الصلاة واتجاه القبلة في بلدك',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _images.length,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return _buildPage(index);
        },
      ),
    );
  }

  Widget _buildPage(int index) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(_images[index]),
          ),
        ),
        Expanded(
          child: Padding(
            padding: REdgeInsets.all(24.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titles[_currentPage],
                  style: AppTextStyleHelper.font24SemiBoldPrimary,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  descriptions[_currentPage],
                  style: AppTextStyleHelper.font18RegularBlack,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                AddSep7aZekrButton(
                  title: _currentPage != 2 ? 'متابعة' : 'لنبدأ الان ',
                  onPressed: () {
                    if (_currentPage == 2) {
                      final box = Hive.box(AppBoxConstants.onBoardingBox);
                      box.put(0, true).then((_) {
                        if(context.mounted){
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppRoutingConstances.home, (route) => false);
                        }
                      });
                      return;
                    }
                    setState(
                      () {
                        _pageController.nextPage(
                          duration: const Duration(
                            milliseconds: 450,
                          ),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
