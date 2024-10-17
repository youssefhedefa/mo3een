import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.title, required this.controller, this.type});

  final String title;
  final TextEditingController controller;
  final TextInputType? type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return 'الرجاء ادخال البيانات';
        }
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColorHelper.lightCoffeeColor,
        hintText: title,
        hintStyle: AppTextStyleHelper.font14RegularPrimary60,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: AppColorHelper.primaryColor,
          ),
        ),
      ),
    );
  }
}
