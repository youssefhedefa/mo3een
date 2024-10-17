import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/sep7a_zekr_container.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/zekr_data_view_title.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/add_sep7a_zekr_button.dart';

class Sep7aCounter extends StatelessWidget {
  const Sep7aCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 66,
              width: double.infinity,
            ),
            const ZekrDataViewTitle(
              zekrName: 'سبحة الكترونية',
            ),
            const SizedBox(
              height: 24,
            ),
            const Sep7aZekrContainer(),
            const SizedBox(
              height: 24,
            ),
            AddSep7aZekrButton(
              onPressed: () {},
              title: 'البدء من جديد',
            ),
            const Spacer(),
            const Sep7aButton(),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class Sep7aButton extends StatelessWidget {
  const Sep7aButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      focusElevation: 0,
      highlightColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AppIconHelper.sep7aButtonIcon,
          ),
          Text(
            'سبح',
            style: AppTextStyleHelper.font14BoldWhite,
          ),
        ],
      ),
    );
  }
}
