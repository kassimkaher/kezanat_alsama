// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arabic_date_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArabicDateEntryAdapter extends TypeAdapter<ArabicDateEntry> {
  @override
  final int typeId = 3;

  @override
  ArabicDateEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArabicDateEntry(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ArabicDateEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.day);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArabicDateEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
