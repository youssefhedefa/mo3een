import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/utilities/constants.dart';
import 'package:mo3een/features/sep7a/data/models/sep7a_model.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/custom_alert_dialog.dart';

class Sep7aCustomAppBar extends StatelessWidget {
  const Sep7aCustomAppBar({super.key, required this.zekr});

  final Sep7aZekrModel zekr;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        Text(
          'سبحة الكترونية',
          style: AppTextStyleHelper.font16BoldPrimary,
        ),
        IconButton(
          onPressed: () async {
            if (zekr.id > AppConstants.initialSep7aAzkar.length) {
              //await zekr.delete();
              showCustomDialog(context);
            }
          },
          icon: Icon(
            Icons.delete,
            color: zekr.id > AppConstants.initialSep7aAzkar.length
                ? Colors.red
                : Colors.grey,
            size: 30,
          ),
        ),
      ],
    );
  }

  showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(zekr: zekr);
      },
    );
  }
}
