// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthStatsAdapter extends TypeAdapter<MonthStats> {
  @override
  final int typeId = 7;

  @override
  MonthStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthStats(
      completedWorkoutsCount: fields[0] as int,
      exercisesStats: (fields[1] as List).cast<ExerciseStats>(),
      score: fields[2] as int,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MonthStats obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.completedWorkoutsCount)
      ..writeByte(1)
      ..write(obj.exercisesStats)
      ..writeByte(2)
      ..write(obj.score)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
