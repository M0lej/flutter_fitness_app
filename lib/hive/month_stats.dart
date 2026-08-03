import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/exercise_stats.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:collection/collection.dart';

part 'month_stats.g.dart';

@HiveType(typeId: 7)
class MonthStats {
  @HiveField(0)
  int completedWorkoutsCount = 0;

  @HiveField(1)
  List<ExerciseStats> exercisesStats = [];

  // score = sum of exercises stats max score
  @HiveField(2)
  int score = 0;

  @HiveField(3)
  DateTime date;

  factory MonthStats.empty() => MonthStats(
    completedWorkoutsCount: 0,
    exercisesStats: [],
    score: 0,
    date: DateTime.now(),
  );

  static List<ExerciseStats> _getUpdatedExercisesStats(
    List<ExerciseStats> exercisesStats,
    List<Exercise> exercises,
  ) {
    // generate stats for submitted exercises
    List<ExerciseStats> createdExercisesStats = exercises
        .map((Exercise exercise) => ExerciseStats.get(exercise))
        .toList();

    print('created exercises stats length: ${createdExercisesStats.length}');

    // check if there are new exercises with higher score and replace them
    for (ExerciseStats createdExerciseStats in createdExercisesStats) {
      int index = exercisesStats.indexWhere(
        (ExerciseStats oldExerciseStats) =>
            oldExerciseStats.exerciseId == createdExerciseStats.exerciseId,
      );

      if (index == -1) {
        print("New exercise");
        exercisesStats.add(createdExerciseStats);
        continue;
      }

      ExerciseStats oldExerciseStats = exercisesStats[index];

      print('${createdExerciseStats.maxScore} ${oldExerciseStats.maxScore}');
      if (createdExerciseStats.maxScore > oldExerciseStats.maxScore) {
        print("Found existing, replacing");
        exercisesStats.remove(oldExerciseStats);
        exercisesStats.insert(index, createdExerciseStats);
      }
    }

    return exercisesStats;
  }

  static int _calculateScore(List<ExerciseStats> exercisesStats) =>
      exercisesStats.isEmpty
      ? 0
      : exercisesStats
            .map((ExerciseStats exerciseStats) => exerciseStats.maxScore)
            .reduce((a, b) => a + b);

  void update(List<Exercise> exercises) {
    completedWorkoutsCount += exercises.length;
    exercisesStats = _getUpdatedExercisesStats(exercisesStats, exercises);
    score = _calculateScore(exercisesStats);
  }

  MonthStats({
    required this.completedWorkoutsCount,
    required this.exercisesStats,
    required this.score,
    required this.date,
  });
}
