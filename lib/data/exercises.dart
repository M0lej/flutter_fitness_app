import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gym_app/data/exercise_indexes.dart';
import 'package:gym_app/hive/exercise.dart';

class ExerciseRepository {
  final List<Exercise> exercises = [];
  Future<void> loadExercises() async {
    for (String exerciseIndex in exerciseIndexes) {
      final String response = await rootBundle.loadString(
        'assets/exercises/$exerciseIndex.json',
      );
      final jsonData = await json.decode(response);

      exercises.add(Exercise.fromJson(jsonData));
    }
  }
}
