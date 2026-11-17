import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gym_app/data/exercise_indexes.dart';
import 'package:gym_app/hive/exercise.dart';

class ExerciseRepository {
  final List<Exercise> exercises = [];
  Future<void> loadExercises() async {
    exercises.clear();

    const batchSize = 25;
    for (var start = 0; start < exerciseIndexes.length; start += batchSize) {
      final batch = exerciseIndexes.skip(start).take(batchSize);
      final loadedExercises = await Future.wait(
        batch.map((exerciseIndex) async {
          try {
            final response = await rootBundle.loadString(
              'assets/exercises/$exerciseIndex.json',
            );
            final jsonData = json.decode(response) as Map<String, dynamic>;
            return Exercise.fromJson(jsonData);
          } catch (error) {
            return null;
          }
        }),
      );

      exercises.addAll(loadedExercises.whereType<Exercise>());
    }

    if (exercises.isEmpty) {
      throw Exception('Exercise library could not be loaded');
    }
  }
}
