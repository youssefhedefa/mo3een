class AzkarModel {
  final dynamic id;
  final String category;
  final String audio;
  final String filename;
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

class ZekrItem {
  final dynamic id;
  final String text;
  final int count;
  final String audio;
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
