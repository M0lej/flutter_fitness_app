// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseStatsAdapter extends TypeAdapter<ExerciseStats> {
  @override
  final int typeId = 8;

  @override
  ExerciseStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseStats(
      exerciseId: fields[0] as String,
      maxScore: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseStats obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.exerciseId)
      ..writeByte(1)
      ..write(obj.maxScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
