import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class ZekrDataViewTitle extends StatelessWidget {
  const ZekrDataViewTitle({super.key, required this.zekrName});
  final String zekrName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColorHelper.primaryColor,
              ),
            ),
          ),
          Text(
            zekrName,
            style: AppTextStyleHelper.font16BoldPrimary,
          ),
        ],
      ),
    );
  }
}
