import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 4)
class DataModel {
  @HiveField(0)
  List<Plan> plans;

  @HiveField(1)
  List<WorkoutLog> workoutLogs;

  @HiveField(2)
  WorkoutLog? activeWorkout;

  DataModel({
    required this.plans,
    required this.workoutLogs,
    required this.activeWorkout,
  });
}
