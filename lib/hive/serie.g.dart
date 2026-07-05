// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SerieAdapter extends TypeAdapter<Serie> {
  @override
  final int typeId = 5;

  @override
  Serie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Serie(
      reps: fields[0] as int,
      weight: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Serie obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.reps)
      ..writeByte(1)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SerieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
