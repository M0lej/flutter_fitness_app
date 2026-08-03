// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataModelAdapter extends TypeAdapter<DataModel> {
  @override
  final int typeId = 4;

  @override
  DataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataModel(
      plans: (fields[0] as List).cast<Plan>(),
      workoutLogs: (fields[1] as List).cast<WorkoutLog>(),
      activeWorkout: fields[2] as WorkoutLog?,
      customExercises: (fields[3] as List).cast<Exercise>(),
      monthsStats: (fields[5] as List).cast<MonthStats>(),
      completedWorkoutsCount: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.plans)
      ..writeByte(1)
      ..write(obj.workoutLogs)
      ..writeByte(2)
      ..write(obj.activeWorkout)
      ..writeByte(3)
      ..write(obj.customExercises)
      ..writeByte(4)
      ..write(obj.completedWorkoutsCount)
      ..writeByte(5)
      ..write(obj.monthsStats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
