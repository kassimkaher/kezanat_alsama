// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingModelAdapter extends TypeAdapter<SettingModel> {
  @override
  final int typeId = 0;

  @override
  SettingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingModel()
      ..isDarkMode = fields[0] as int
      ..city = fields[1] as int?
      ..enableNotification = fields[2] as bool
      ..isSetNotification = fields[3] as int
      ..selectCity = fields[4] as CityDetails?;
  }

  @override
  void write(BinaryWriter writer, SettingModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isDarkMode)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.enableNotification)
      ..writeByte(3)
      ..write(obj.isSetNotification)
      ..writeByte(4)
      ..write(obj.selectCity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CityDetailsAdapter extends TypeAdapter<CityDetails> {
  @override
  final int typeId = 1;

  @override
  CityDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CityDetails(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as double?,
      fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, CityDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.nameAr)
      ..writeByte(2)
      ..write(obj.latitude)
      ..writeByte(3)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CityDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SalatContinusAdapter extends TypeAdapter<SalatContinus> {
  @override
  final int typeId = 2;

  @override
  SalatContinus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalatContinus()
      ..day = fields[0] as int
      ..salaNumber = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, SalatContinus obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.salaNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalatContinusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
