import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:hive_flutter/adapters.dart';

part 'exercise_stats.g.dart';

@HiveType(typeId: 8)
class ExerciseStats {
  @HiveField(0)
  String exerciseId;

  // score = weight * reps
  @HiveField(1)
  int maxScore;

  static int _calculateMaxScore(List<WorkoutSet> workoutSets) {
    int currentMaxScore = 0;
    for (WorkoutSet workoutSet in workoutSets) {
      double weight = workoutSet.weight == 0 ? 1 : workoutSet.weight;

      int score = (weight * workoutSet.reps).toInt();

      currentMaxScore += score;
    }
    return currentMaxScore;
  }

  factory ExerciseStats.get(Exercise exercise) => ExerciseStats(
    exerciseId: exercise.id,
    maxScore: _calculateMaxScore(exercise.workoutSets),
  );

  ExerciseStats({required this.exerciseId, required this.maxScore});
}
