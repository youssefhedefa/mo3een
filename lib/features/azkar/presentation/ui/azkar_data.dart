import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3een/features/azkar/data/model/zekr_item_model.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/zekr_data_view_title.dart';
import 'package:mo3een/features/azkar/presentation/ui/widgets/zekr_item_shower.dart';

class AzkarDataView extends StatelessWidget {
  const AzkarDataView({super.key, required this.zekr});

  final ZekrItemModel zekr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(
              height: 66,
              width: double.infinity,
            ),
            ZekrDataViewTitle(zekrName: zekr.zekrName),
            SizedBox(
              height: 24.h,
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: zekr.zekr.length,
                itemBuilder: (context, index) {
                  return ZekItemShower(
                    zekr: zekr.zekr[index].text,
                    count: zekr.zekr[index].count,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}