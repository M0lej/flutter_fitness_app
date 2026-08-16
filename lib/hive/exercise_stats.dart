import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:hive_flutter/adapters.dart';

part 'exercise_stats.g.dart';

@HiveType(typeId: 8)
class ExerciseStats {
  @HiveField(0)
  String exerciseId;

  @HiveField(1)
  double maxWeight;

  @HiveField(2)
  int maxReps;

  @HiveField(3)
  List<WorkoutSet> lastWorkoutSets;

  @HiveField(4)
  WeightUnit weightUnit;

  factory ExerciseStats.create(Exercise exercise) => ExerciseStats(
    exerciseId: exercise.id,
    maxReps: 0,
    maxWeight: 0,
    lastWorkoutSets: exercise.workoutSets,
    weightUnit: exercise.weightUnit,
  );

  ExerciseStats({
    required this.exerciseId,
    required this.maxReps,
    required this.maxWeight,
    required this.lastWorkoutSets,
    required this.weightUnit,
  });
}
