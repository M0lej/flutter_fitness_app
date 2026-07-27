import 'package:gym_app/hive/plan.dart';
import 'package:hive/hive.dart';

part 'workout_log.g.dart';

@HiveType(typeId: 3)
class WorkoutLog {
  @HiveField(0)
  final Plan plan;

  @HiveField(1)
  final DateTime start;

  @HiveField(2)
  final DateTime? end;

  @HiveField(3)
  final String id;

  WorkoutLog copy() =>
      WorkoutLog(plan: plan.copy(), start: start, end: end, id: id);

  WorkoutLog copyWith({
    Plan? plan,
    DateTime? start,
    DateTime? end,
    String? id,
  }) => WorkoutLog(
    plan: plan ?? this.plan,
    start: start ?? this.start,
    end: end ?? this.end,
    id: id ?? this.id,
  );

  WorkoutLog({
    required this.plan,
    required this.start,
    required this.end,
    required this.id,
  });
}
