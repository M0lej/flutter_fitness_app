// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_workout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActiveWorkoutAdapter extends TypeAdapter<ActiveWorkout> {
  @override
  final int typeId = 11;

  @override
  ActiveWorkout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActiveWorkout(
      completedExercisesIds: (fields[4] as List?)?.cast<String>(),
      plan: fields[0] as Plan,
      start: fields[1] as DateTime,
      end: fields[2] as DateTime?,
      id: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ActiveWorkout obj) {
    writer
      ..writeByte(5)
      ..writeByte(4)
      ..write(obj.completedExercisesIds)
      ..writeByte(0)
      ..write(obj.plan)
      ..writeByte(1)
      ..write(obj.start)
      ..writeByte(2)
      ..write(obj.end)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveWorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
