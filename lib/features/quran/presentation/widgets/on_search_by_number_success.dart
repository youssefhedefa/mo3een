import 'package:flutter/material.dart';
import 'package:mo3een/core/helpers/text_style_helper.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';
import 'package:mo3een/features/quran/presentation/widgets/page_result.dart';
import 'package:mo3een/features/quran/presentation/widgets/surah_container.dart';
import 'package:quran/quran.dart';

class OnSearchByNumberSuccess extends StatelessWidget {
  const OnSearchByNumberSuccess(
      {super.key, required this.number, this.searchResults});

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
                      onTap: (){
                        int page = getPageNumber(searchResults[0].number, 1);
                        Navigator.pushNamed(
                          context,
                          AppRoutingConstances.quranPage,
                          arguments: QuranPageModel(pageNumber: page),
                        );
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
