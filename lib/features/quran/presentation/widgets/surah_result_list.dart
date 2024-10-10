import 'package:flutter/material.dart';
import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';
import 'package:mo3een/features/quran/presentation/widgets/surah_container.dart';


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
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
