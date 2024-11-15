import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({Key? key, required this.text,}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: (){
          shareZekr(context);
        },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: AppColorHelper.primaryColor,
        ),
      ),
      child: Row(
        children: [
          Text(
            'نسخ ',
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

  shareZekr(BuildContext context) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ الذكر بنجاح'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
