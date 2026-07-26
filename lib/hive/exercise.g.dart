// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 1;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      name: fields[0] as String,
      force: fields[1] as String?,
      level: fields[2] as String?,
      mechanic: fields[3] as String?,
      equipment: fields[4] as String?,
      primaryMuscles: (fields[5] as List?)?.cast<dynamic>(),
      secondaryMuscles: (fields[6] as List?)?.cast<dynamic>(),
      instructions: (fields[7] as List?)?.cast<dynamic>(),
      category: fields[8] as String,
      workoutSets: (fields[9] as List).cast<WorkoutSet>(),
      weightUnit: fields[10] as WeightUnit,
      images: (fields[11] as List).cast<dynamic>(),
      id: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.force)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.mechanic)
      ..writeByte(4)
      ..write(obj.equipment)
      ..writeByte(5)
      ..write(obj.primaryMuscles)
      ..writeByte(6)
      ..write(obj.secondaryMuscles)
      ..writeByte(7)
      ..write(obj.instructions)
      ..writeByte(8)
      ..write(obj.category)
      ..writeByte(9)
      ..write(obj.workoutSets)
      ..writeByte(10)
      ..write(obj.weightUnit)
      ..writeByte(11)
      ..write(obj.images)
      ..writeByte(12)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
