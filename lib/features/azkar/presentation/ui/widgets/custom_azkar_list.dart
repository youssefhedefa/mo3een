import 'package:flutter/material.dart';
import 'package:mo3een/features/azkar/data/model/azkar_model.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/custom_zekr_item.dart';

class CustomAzkarList extends StatelessWidget {
  const CustomAzkarList({super.key, required this.azkar});

  final List<AzkarModel> azkar;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return CustomZekrItem(
            zekr: azkar[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: azkar.length,
      ),
    );
  }
}
