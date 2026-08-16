import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/exercise_stats.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:hive_flutter/adapters.dart';

part 'month_stats.g.dart';

@HiveType(typeId: 7)
class MonthStats {
  @HiveField(0)
  int completedWorkoutsCount = 0;

  @HiveField(1)
  List<WorkoutLog> currentMonthWorkoutLogs = [];

  // score = sum of exercises stats max score
  @HiveField(2)
  int score = 0;

  @HiveField(3)
  DateTime date;

  factory MonthStats.empty() => MonthStats(
    completedWorkoutsCount: 0,
    currentMonthWorkoutLogs: [],
    score: 0,
    date: DateTime.now(),
  );

  void _updateScore() {
    if (currentMonthWorkoutLogs.isEmpty) {
      score = 0;
      return;
    }

    int newScore = currentMonthWorkoutLogs
        .map((WorkoutLog workoutLog) => _getWorkoutScore(workoutLog))
        .reduce((a, b) => a + b);
    score = newScore;
  }

  int _getWorkoutScore(WorkoutLog workoutLog) {
    if (workoutLog.plan.exercises.isEmpty) return 0;

    int workoutScore = workoutLog.plan.exercises
        .map((Exercise exercise) => _getExerciseScore(exercise))
        .reduce((a, b) => a + b);
    return workoutScore;
  }

  int _getExerciseScore(Exercise exercise) {
    if (exercise.workoutSets.isEmpty) return 0;

    int exerciseScore = exercise.workoutSets
        .map((WorkoutSet workoutSet) => workoutSet.reps * workoutSet.weight)
        .reduce((a, b) => a + b)
        .toInt();
    return exerciseScore;
  }

  void update(List<WorkoutLog> workoutLogs) {
    currentMonthWorkoutLogs = workoutLogs
        .where(
          (WorkoutLog workoutLog) =>
              workoutLog.end!.month == DateTime.now().month,
        )
        .toList();
    _updateScore();
  }

  MonthStats({
    required this.completedWorkoutsCount,
    required this.score,
    required this.date,
    required this.currentMonthWorkoutLogs,
  });
}
