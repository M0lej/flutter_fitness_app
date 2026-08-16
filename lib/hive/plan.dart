import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:hive/hive.dart';

part 'plan.g.dart';

const Map<String, Widget> icons = {
  'dumbbell': FaIcon(FontAwesomeIcons.dumbbell),
  'sports_baseball': Icon(Icons.sports_baseball),
  'sports': Icon(Icons.sports),
  'sports_gymnastics': Icon(Icons.sports_gymnastics),
  'sports_mma': Icon(Icons.sports_mma),
};

@HiveType(typeId: 2)
class Plan {
  @HiveField(0)
  String name;

  @HiveField(2)
  List<Exercise> exercises;

  @HiveField(3)
  DateTime creationDate;

  @HiveField(4)
  String iconName;

  @HiveField(5)
  final String id;

  Plan({
    required this.name,
    required this.exercises,
    required this.creationDate,
    required this.iconName,
    required this.id,
  });

  Widget get icon =>
      icons.keys.contains(iconName) ? icons[iconName]! : Icon(null);

  Plan copy() => Plan(
    name: name,
    exercises: exercises.map((Exercise exercise) => exercise.copy()).toList(),
    creationDate: creationDate,
    iconName: iconName,
    id: id,
  );

  bool isDifferent(Plan other) {
    if (name != other.name ||
        id != other.id ||
        exercises.length != other.exercises.length) {
      return true;
    }

    for (Exercise exercise in exercises) {
      if (other.exercises.indexWhere((Exercise e) => e.id == exercise.id) ==
          -1) {
        return true;
      }
    }

    return false;
  }
}

Widget getIconWidgetByName(String iconName) =>
    icons.keys.contains(iconName) ? icons[iconName]! : Icon(null);
