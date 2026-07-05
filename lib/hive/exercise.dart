import 'package:gym_app/hive/serie.dart';
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
  List<Serie> series;

  @HiveField(10)
  final List<dynamic> images;

  @HiveField(11)
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
    required this.series,
    required this.images,
    required this.id,
  });

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
      series: [],
      images: json["images"],
      id: json["id"],
    );
  }
}
