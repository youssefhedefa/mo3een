import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/sep7a_zekr_container.dart';
import 'package:mo3een/features/sep7a/data/models/sep7a_model.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/add_sep7a_zekr_button.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/sep7a_button.dart';
import 'package:mo3een/features/sep7a/presentation/ui/widgets/sep7a_custom_app_bar.dart';

class Sep7aCounter extends StatefulWidget {
  const Sep7aCounter({super.key, required this.zkr});

  final Sep7aZekrModel zkr;

  @override
  State<Sep7aCounter> createState() => _Sep7aCounterState();
}

class _Sep7aCounterState extends State<Sep7aCounter> {

  int currentCount = 0;
  int cycleNumber = 0;
  int totalCount = 0;

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
            // const ZekrDataViewTitle(
            //   zekrName: 'سبحة الكترونية',
            // ),
            Sep7aCustomAppBar(
              zekr: widget.zkr,
            ),
            const SizedBox(
              height: 24,
            ),
            Sep7aZekrContainer(
              title: widget.zkr.title,
              count: widget.zkr.count,
              currentCount: currentCount,
              cycleNumber: cycleNumber,
              totalCount: totalCount,
            ),
            const SizedBox(
              height: 24,
            ),
            AddSep7aZekrButton(
              onPressed: () {
                setState(() {
                  currentCount = 0;
                  cycleNumber = 0;
                  totalCount = 0;
                });
              },
              title: 'البدء من جديد',
            ),
            const Spacer(),
            Sep7aButton(
              onPressed: () {
                setState(() {
                  currentCount++;
                  totalCount++;
                  if (currentCount == widget.zkr.count) {
                    cycleNumber++;
                    currentCount = 0;
                  }
                });
              },
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
