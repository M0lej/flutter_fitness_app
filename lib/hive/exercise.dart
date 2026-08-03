import 'package:gym_app/hive/workout_set.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:hive/hive.dart';

part 'exercise.g.dart';

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? force;

  @HiveField(2)
  final String? level;

  @HiveField(3)
  final String? mechanic;

  @HiveField(4)
  final String? equipment;

  @HiveField(5)
  final List<dynamic>? primaryMuscles;

  @HiveField(6)
  final List<dynamic>? secondaryMuscles;

  @HiveField(7)
  final List<dynamic>? instructions;

  @HiveField(8)
  final String category;

  @HiveField(9)
  List<WorkoutSet> workoutSets;

  @HiveField(10)
  WeightUnit weightUnit;

  @HiveField(11)
  final List<dynamic> images;

  @HiveField(12)
  final String id;

  Exercise({
    required this.name,
    required this.force,
    required this.level,
    required this.mechanic,
    required this.equipment,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.instructions,
    required this.category,
    required this.workoutSets,
    required this.weightUnit,
    required this.images,
    required this.id,
  });

  Exercise copy() => Exercise(
    name: name,
    workoutSets: workoutSets.map((s) => s.copy()).toList(),
    force: force,
    level: level,
    mechanic: mechanic,
    equipment: equipment,
    primaryMuscles: primaryMuscles,
    secondaryMuscles: secondaryMuscles,
    instructions: instructions,
    category: category,
    weightUnit: weightUnit,
    images: images,
    id: id,
  );

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      force: json['force'],
      level: json["level"],
      mechanic: json["mechanic"],
      equipment: json["equipment"],
      primaryMuscles: json["primaryMuscles"],
      secondaryMuscles: json["secondaryMuscles"],
      instructions: json["instructions"],
      category: json["category"],
      workoutSets: [],
      weightUnit: WeightUnit.kg,
      images: json["images"],
      id: json["id"],
    );
  }
}
