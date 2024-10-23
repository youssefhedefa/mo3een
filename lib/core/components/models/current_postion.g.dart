// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_postion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentPositionAdapter extends TypeAdapter<CurrentPosition> {
  @override
  final int typeId = 5;

  @override
  CurrentPosition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentPosition(
      latitude: fields[0] as double,
      longitude: fields[1] as double,
      lastUpdate: fields[2] as DateTime,
      address: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentPosition obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.latitude)
      ..writeByte(1)
      ..write(obj.longitude)
      ..writeByte(2)
      ..write(obj.lastUpdate)
      ..writeByte(3)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentPositionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
