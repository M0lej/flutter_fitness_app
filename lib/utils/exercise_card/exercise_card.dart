import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:gym_app/settings/languages/translations.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/exercise_card/order_change_buttons.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/my_image.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final Function(Exercise) removeExercise;
  final Function(Exercise, bool) changeOrder;
  final Translations translations;

  final bool isFirst;
  final bool isLast;
  final bool showSets;
  final bool isCompleted;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.removeExercise,
    this.isFirst = false,
    this.isLast = false,
    this.showSets = false,
    required this.changeOrder,
    this.isCompleted = false,
    required this.translations,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: isCompleted ? AppTheme.red : null,
      index: 0,
      onLongPress: () => showYesNoDialog(
        title: translations.removeExercise,
        onYes: () => removeExercise(exercise),
        appContext: context,
        translations: translations,
      ),
      children: [
        Row(
          spacing: 15,
          children: [
            if (exercise.images.isNotEmpty)
              MyImage(
                size: 150,
                path: './assets/exercises/${exercise.images[0]}',
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    exercise.name,
                    maxLines: 2,
                    maxFontSize: 15,
                    style: TextStyle(fontSize: 15),
                  ),

                  AutoSizeText(
                    [
                      ...exercise.primaryMuscles ?? [],
                      ...exercise.secondaryMuscles ?? [],
                    ].join(", "),
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  if (showSets)
                    Text(
                      // map rep labels to format [occurrences] x [rep label]
                      "${exercise.workoutSets.map((WorkoutSet workoutSet) => '${workoutSet.reps} x ${workoutSet.weight} ${exercise.weightUnit.name}').toList().sublist(0, min(exercise.workoutSets.length, 4)).join('\n')}${exercise.workoutSets.length > 4 ? '\n...' : ''}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),

        // if exercise is completed hide the divider and add a background to order change buttons
        if (!isCompleted && !(isFirst && isLast))
          Divider(
            thickness: 0.5,
            height: 1,
            color: Theme.of(context).focusColor,
          ),

        if (isCompleted && !(isFirst && isLast))
          Card(
            child: OrderChangeButtons(
              changeOrder: changeOrder,
              exercise: exercise,
              isFirst: isFirst,
              isLast: isLast,
            ),
          ),

        if (!isCompleted && !(isFirst && isLast))
          OrderChangeButtons(
            changeOrder: changeOrder,
            exercise: exercise,
            isFirst: isFirst,
            isLast: isLast,
          ),
      ],
    );
  }
}
