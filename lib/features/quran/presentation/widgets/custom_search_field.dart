import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/color_helper.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({super.key, required this.enabled, this.onChanged, this.searchController, this.searchFocusNode});

  final bool enabled;
  final Function(String)? onChanged;
  final TextEditingController? searchController;
  final FocusNode? searchFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      enabled: enabled,
      onChanged: onChanged,
      focusNode: searchFocusNode,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'ابحث عن سوره, صفحه, رقم الصفحه او الايه',
        hintStyle: AppTextStyleHelper.font14RegularPrimary60,
        suffixIcon: const Icon(
            Icons.search,
          color: AppColorHelper.primaryColor,
          size: 30,
        ),
        fillColor: AppColorHelper.lightCoffeeColor,
        filled: true,
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColorHelper.primaryColor,
        width: 1.5,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    );
  }

}
