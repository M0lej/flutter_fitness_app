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
      maxReps: fields[2] as int,
      maxWeight: fields[1] as double,
      lastWorkoutSets: (fields[3] as List).cast<WorkoutSet>(),
      weightUnit: fields[4] as WeightUnit,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseStats obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.exerciseId)
      ..writeByte(1)
      ..write(obj.maxWeight)
      ..writeByte(2)
      ..write(obj.maxReps)
      ..writeByte(3)
      ..write(obj.lastWorkoutSets)
      ..writeByte(4)
      ..write(obj.weightUnit);
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
