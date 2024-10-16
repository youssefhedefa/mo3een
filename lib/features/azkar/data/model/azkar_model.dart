import 'package:hive/hive.dart';

part 'azkar_model.g.dart';

@HiveType(typeId: 1)
class AzkarModel extends HiveObject {
  @HiveField(0)
  final dynamic id;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final String audio;
  @HiveField(3)
  final String filename;
  @HiveField(4)
  final List<ZekrItem> array;

  AzkarModel({
    required this.id,
    required this.category,
    required this.audio,
    required this.filename,
    required this.array,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    var array = json['array'] as List;
    List<ZekrItem> duaItems =
        array.map((item) => ZekrItem.fromJson(item)).toList();

    return AzkarModel(
      id: json['id'],
      category: json['category'],
      audio: json['audio'],
      filename: json['filename'],
      array: duaItems,
    );
  }
}

@HiveType(typeId: 2)
class ZekrItem {
  @HiveField(0)
  final dynamic id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final int count;
  @HiveField(3)
  final String audio;
  @HiveField(4)
  final String filename;

  ZekrItem({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  factory ZekrItem.fromJson(Map<String, dynamic> json) {
    return ZekrItem(
      id: json['id'],
      text: json['text'],
      count: json['count'],
      audio: json['audio'],
      filename: json['filename'],
    );
  }
}
