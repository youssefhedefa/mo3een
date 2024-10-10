import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/quran/presentation/widgets/all_surahs_list.dart';
import 'package:mo3een/features/quran/presentation/widgets/continue_reading.dart';
import 'package:mo3een/features/quran/presentation/widgets/custom_search_field.dart';
import 'package:mo3een/features/quran/presentation/widgets/tab_bar.dart';
//import 'package:quran/quran.dart' as quran;

class QuranView extends StatelessWidget {
  const QuranView({super.key});

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
            Text(
              'القرآن الكريم',
              style: AppTextStyleHelper.font16BoldPrimary,
            ),
            const SizedBox(height: 24),
            const ContinueReading(),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutingConstances.search);
              },
                child: const CustomSearchField(enabled: false,),
            ),
            const SizedBox(height: 16),
            const CustomTabBar(),
            const SizedBox(height: 16),
            const AllSurahList(),
          ],
        ),
      ),
    );
  }
}
