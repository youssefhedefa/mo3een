import 'package:flutter/material.dart';
import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';
import 'package:quran/quran.dart';

class SurahHeader extends StatelessWidget {
  const SurahHeader({super.key, required this.surah});

  final SuraEntity surah;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/888-02.png",
              width: MediaQuery.of(context).size.width,
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.7, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "اياتها\n${getVerseCount(surah.number)}",
                  style: const TextStyle(
                      fontSize: 5, fontFamily: "UthmanicHafs13"),
                ),
                Center(
                    child: RichText(
                        text: TextSpan(
                  text: surah.name,

                  // textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "arsura", fontSize: 22, color: Colors.black),
                ))),
                Text(
                  "ترتيبها\n${surah.name}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 5, fontFamily: "UthmanicHafs13"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
