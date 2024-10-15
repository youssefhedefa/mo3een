import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:mo3een/features/quran/data/models/sura_model.dart';
import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';
import 'package:mo3een/features/quran/domain/repo/quran_repo.dart';

class QuranRepoImple implements QuranRepo {
  @override
  Future<List<SuraEntity>> getAllSuras() async {
    final String jsonData = await rootBundle.loadString('assets/json/surahs.json');
    var data = jsonDecode(jsonData);
    List<SuraEntity> suras = Surah.createSuraEntities(data);
    log(suras.length.toString());
    return suras;
  }

}