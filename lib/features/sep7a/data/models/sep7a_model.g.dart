// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sep7a_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Sep7aZekrModelAdapter extends TypeAdapter<Sep7aZekrModel> {
  @override
  final int typeId = 3;

  @override
  Sep7aZekrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sep7aZekrModel(
      id: fields[0] as int,
      title: fields[1] as String,
      count: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Sep7aZekrModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sep7aZekrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
