import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'workout_set.g.dart';

@HiveType(typeId: 5)
class WorkoutSet {
  @HiveField(0)
  int reps;

  @HiveField(1)
  double weight;

  @HiveField(2)
  String id;

  WorkoutSet({required this.reps, required this.weight, required this.id});

  WorkoutSet copy() =>
      WorkoutSet(reps: reps, weight: weight, id: Uuid().v1().toString());
}
