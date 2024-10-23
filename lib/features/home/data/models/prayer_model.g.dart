// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PrayerModelAdapter extends TypeAdapter<PrayerModel> {
  @override
  final int typeId = 4;

  @override
  PrayerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PrayerModel(
      prayer: fields[0] as String,
      time: fields[1] as String,
      icon: fields[2] as String,
      hisTurn: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PrayerModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.prayer)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.icon)
      ..writeByte(3)
      ..write(obj.hisTurn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
