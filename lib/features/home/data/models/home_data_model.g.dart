// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeDataModelAdapter extends TypeAdapter<HomeDataModel> {
  @override
  final int typeId = 10;

  @override
  HomeDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeDataModel(
      location: fields[0] as String?,
      nextPrayer: fields[1] as String?,
      prayers: (fields[4] as List?)?.cast<PrayerModel>(),
      nextPrayerTimeHoursLeft: fields[2] as int?,
      nextPrayerTimeMinutesLeft: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HomeDataModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.location)
      ..writeByte(1)
      ..write(obj.nextPrayer)
      ..writeByte(2)
      ..write(obj.nextPrayerTimeHoursLeft)
      ..writeByte(3)
      ..write(obj.nextPrayerTimeMinutesLeft)
      ..writeByte(4)
      ..write(obj.prayers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
