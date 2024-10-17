import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: (){},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: AppColorHelper.primaryColor,
        ),
      ),
      child: Row(
        children: [
          Text(
            'مشاركة ',
            style: AppTextStyleHelper.font14RegularPrimary,
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(
            Icons.copy_rounded,
            color: AppColorHelper.primaryColor,
          ),
        ],
      ),
    );
  }
}
