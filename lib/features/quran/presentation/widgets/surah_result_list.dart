import 'package:flutter/material.dart';
import 'package:mo3een/core/routing/routing_constances.dart';
import 'package:mo3een/features/quran/data/models/quran_page_model.dart';
import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';
import 'package:mo3een/features/quran/presentation/widgets/surah_container.dart';
import 'package:quran/quran.dart';


class SurahsResultList extends StatelessWidget {
  const SurahsResultList({super.key, required this.results});

  final List<SuraEntity> results;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: results.length,
        itemBuilder: (context, index) {
          return SurahContainer(
            surah: results[index],
            onTap: (){
              int page = getPageNumber(results[index].number, 1);
              Navigator.pushNamed(
                context,
                AppRoutingConstances.quranPage,
                arguments: QuranPageModel(pageNumber: page),
              );
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
