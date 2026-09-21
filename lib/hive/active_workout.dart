import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'active_workout.g.dart';

@HiveType(typeId: 11)
class ActiveWorkout extends WorkoutLog {
  @HiveField(4)
  final List<String>? completedExercisesIds;

  @override
  ActiveWorkout copy() => ActiveWorkout(
    completedExercisesIds: completedExercisesIds,
    plan: super.plan,
    start: super.start,
    end: super.end,
    id: super.id,
  );

  @override
  ActiveWorkout copyWith({
    List<String>? completedExercisesIds,
    Plan? plan,
    DateTime? start,
    DateTime? end,
    String? id,
  }) => ActiveWorkout(
    completedExercisesIds: completedExercisesIds ?? this.completedExercisesIds,
    plan: plan ?? super.plan,
    start: start ?? super.start,
    end: end ?? super.end,
    id: id ?? super.id,
  );

  ActiveWorkout({
    required this.completedExercisesIds,
    required super.plan,
    required super.start,
    required super.end,
    required super.id,
  });
}
