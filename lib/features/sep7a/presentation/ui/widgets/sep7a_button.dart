import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mo3een/core/helpers/icon_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';


class Sep7aButton extends StatelessWidget {
  const Sep7aButton({super.key, this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
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
