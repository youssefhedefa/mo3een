// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quran_mark_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuranMarkModelAdapter extends TypeAdapter<QuranMarkModel> {
  @override
  final int typeId = 0;

  @override
  QuranMarkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuranMarkModel(
      id: fields[0] as int?,
      surah: fields[1] as int?,
      ayah: fields[2] as int?,
      marks: (fields[4] as List?)?.cast<int>(),
      page: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, QuranMarkModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.surah)
      ..writeByte(2)
      ..write(obj.ayah)
      ..writeByte(3)
      ..write(obj.page)
      ..writeByte(4)
      ..write(obj.marks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuranMarkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
