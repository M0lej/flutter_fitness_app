import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:hive/hive.dart';

part 'plan.g.dart';

Map<String, Widget> icons = {
  FontAwesomeIcons.dumbbell.toString(): FaIcon(FontAwesomeIcons.dumbbell),
  Icons.sports_baseball.toString(): Icon(Icons.sports_baseball),
  Icons.sports.toString(): Icon(Icons.sports),
  Icons.sports_gymnastics.toString(): Icon(Icons.sports_gymnastics),
  Icons.sports_mma.toString(): Icon(Icons.sports_mma),
};

@HiveType(typeId: 2)
class Plan {
  @HiveField(0)
  final String name;

  @HiveField(2)
  final List<Exercise> exercises;

  @HiveField(3)
  final DateTime creationDate;

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

      Exercise otherExercise = other.exercises.firstWhere(
        (Exercise e) => e.id == exercise.id,
      );

      if (otherExercise.workoutSets.length != exercise.workoutSets.length) {
        return true;
      }

      if (otherExercise.weightUnit != exercise.weightUnit) {
        return true;
      }

      for (WorkoutSet workoutSet in exercise.workoutSets) {
        if (otherExercise.workoutSets.indexWhere(
              (WorkoutSet s) =>
                  s.reps == workoutSet.reps && s.weight == workoutSet.weight,
            ) ==
            -1) {
          return true;
        }

        // if (otherExercise.workoutSets.indexWhere(
        //       (WorkoutSet s) => s.id == workoutSet.id,
        //     ) !=
        //     exercise.workoutSets.indexOf(workoutSet)) {
        //   print('4');

        //   return true;
        // }
      }
    }

    return false;
  }
}

Widget getIconWidgetByName(String iconName) =>
    icons.keys.contains(iconName) ? icons[iconName]! : Icon(null);
