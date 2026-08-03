import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/my_image.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final Function(Exercise) removeExercise;
  final Function(Exercise, bool) changeOrder;

  final bool? isFirst;
  final bool? isLast;
  final bool? showSets;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.removeExercise,
    this.isFirst = false,
    this.isLast = false,
    this.showSets = false,
    required this.changeOrder,
  });

  @override
  Widget build(BuildContext context) {
    // get rep counts
    List<int> reps = exercise.workoutSets
        .map((WorkoutSet workoutSet) => workoutSet.reps)
        .toList();

    // get unique rep labels for ex if I have list of reps like this [12,12,10,5] I would get [12,10,5]
    Set<int> uniqueReps = reps.toSet();

    // count how many times each rep label occur in reps list for ex. [2,1,1]
    List<int> occurrences = uniqueReps
        .map(
          (int repCountA) =>
              reps.where((int repCountB) => repCountA == repCountB).length,
        )
        .toList();

    return CustomCard(
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
                  if (showSets!)
                    Text(
                      // map rep labels to format [occurrences] x [rep label]
                      uniqueReps
                          .map(
                            (int repCount) =>
                                // get index of repCount in uniqueReps because dart for some reason doesn't provide index property in map function lol, then get occurrences count at the same index
                                '${occurrences[uniqueReps.toList().indexOf(repCount)]} x $repCount reps',
                          )
                          .join('\n'),
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
        Divider(thickness: 0.5, height: 1, color: Theme.of(context).focusColor),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (!isFirst!)
                  IconButton(
                    onPressed: () => changeOrder(exercise, true),
                    icon: Icon(Icons.keyboard_arrow_up),
                  ),
                if (!isLast!)
                  IconButton(
                    onPressed: () => changeOrder(exercise, false),
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
              ],
            ),
            IconButton(
              onPressed: () => removeExercise(exercise),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ],
    );
  }
}
