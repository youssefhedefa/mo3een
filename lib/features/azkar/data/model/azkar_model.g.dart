// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'azkar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AzkarModelAdapter extends TypeAdapter<AzkarModel> {
  @override
  final int typeId = 1;

  @override
  AzkarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AzkarModel(
      id: fields[0] as dynamic,
      category: fields[1] as String,
      audio: fields[2] as String,
      filename: fields[3] as String,
      array: (fields[4] as List).cast<ZekrItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, AzkarModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.audio)
      ..writeByte(3)
      ..write(obj.filename)
      ..writeByte(4)
      ..write(obj.array);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AzkarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ZekrItemAdapter extends TypeAdapter<ZekrItem> {
  @override
  final int typeId = 2;

  @override
  ZekrItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ZekrItem(
      id: fields[0] as dynamic,
      text: fields[1] as String,
      count: fields[2] as int,
      audio: fields[3] as String,
      filename: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ZekrItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.text)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.audio)
      ..writeByte(4)
      ..write(obj.filename);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZekrItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
