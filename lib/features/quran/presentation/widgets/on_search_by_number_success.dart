import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/features/quran/presentation/widgets/page_result.dart';
import 'package:mo3een/features/quran/presentation/widgets/surah_container.dart';


class OnSearchByNumberSuccess extends StatelessWidget {
  const OnSearchByNumberSuccess({super.key, required this.number, this.searchResults});

  final num number;
  final dynamic searchResults;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageResult(
            number: number,
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 1,
          ),
          searchResults.isEmpty
              ? const SizedBox()
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'السوره رقم $number هي:',
                style: AppTextStyleHelper.font16BoldPrimary,
              ),
              const SizedBox(
                height: 16,
              ),
              SurahContainer(
                surah: searchResults[0],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
