import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/exercise_stats.dart';
import 'package:gym_app/hive/month_stats.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 4)
class DataModel {
  static const Object _activeWorkoutSentinel = Object();

  @HiveField(0)
  List<Plan> plans;

  @HiveField(1)
  List<WorkoutLog> workoutLogs;

  @HiveField(2)
  WorkoutLog? activeWorkout;

  @HiveField(3)
  List<Exercise> customExercises;

  @HiveField(4)
  int completedWorkoutsCount = 0;

  // includes statistics of current and previous month
  @HiveField(5)
  List<MonthStats> monthsStats = [];

  @HiveField(6)
  List<ExerciseStats> exercisesStats;

  DataModel copyWith({
    List<Plan>? plans,
    List<WorkoutLog>? workoutLogs,
    Object? activeWorkout = _activeWorkoutSentinel,
    List<Exercise>? customExercises,
    List<MonthStats>? monthsStats,
    int? completedWorkoutsCount,
    List<ExerciseStats>? exercisesStats,
  }) {
    final resolvedActiveWorkout = activeWorkout == _activeWorkoutSentinel
        ? this.activeWorkout
        : activeWorkout as WorkoutLog?;

    return DataModel(
      plans: plans ?? this.plans,
      workoutLogs: workoutLogs ?? this.workoutLogs,
      activeWorkout: resolvedActiveWorkout,
      customExercises: customExercises ?? this.customExercises,
      monthsStats: monthsStats ?? this.monthsStats,
      completedWorkoutsCount: completedWorkoutsCount ?? 0,
      exercisesStats: exercisesStats ?? this.exercisesStats,
    );
  }

  factory DataModel.empty() => DataModel(
    plans: [],
    workoutLogs: [],
    activeWorkout: null,
    customExercises: [],
    monthsStats: [],
    completedWorkoutsCount: 0,
    exercisesStats: [],
  );

  DataModel({
    required this.plans,
    required this.workoutLogs,
    required this.activeWorkout,
    required this.customExercises,
    required this.monthsStats,
    required this.completedWorkoutsCount,
    required this.exercisesStats,
  });
}
