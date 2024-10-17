import 'package:flutter/material.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_item.dart';

class RepeatButton extends StatefulWidget {
  const RepeatButton({super.key, required this.count});

  final int count;

  @override
  State<RepeatButton> createState() => _RepeatButtonState();
}

class _RepeatButtonState extends State<RepeatButton> {

  int currentCount = 0;

  @override
  Widget build(BuildContext context) {
    return CustomTabItem(
      title: 'تكرار ($currentCount/${widget.count}) ',
      isSelected: true,
      onTap: () {
        setState(() {
          if(currentCount != widget.count){
            currentCount++;
          }
        });
      },
    );
  }
}
