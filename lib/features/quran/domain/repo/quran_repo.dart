import 'package:mo3een/features/quran/domain/entities/sura_entity.dart';

abstract class QuranRepo{
  Future<List<SuraEntity>> getAllSuras();
}