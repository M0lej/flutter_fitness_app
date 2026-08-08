import 'package:flutter/material.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/animated_card.dart';

class WorkoutSetItem extends StatelessWidget {
  final Exercise exercise;
  final int index;
  final SettingsProvider settings;
  final Function(int, String) onRepCountChange;
  final Function(int, String) onWeightChange;
  final TextEditingController weightController;
  final Function(WorkoutSet) removeSet;

  const WorkoutSetItem({
    super.key,
    required this.exercise,
    required this.index,
    required this.onRepCountChange,
    required this.onWeightChange,
    required this.settings,
    required this.weightController,
    required this.removeSet,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      index: index,
      key: Key(index.toString()),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 15,
                children: [
                  Column(
                    spacing: 10,
                    children: [
                      SizedBox(
                        width: 90,
                        child: TextFormField(
                          key: Key('${exercise.workoutSets[index].id}_reps'),
                          initialValue: exercise.workoutSets[index].reps
                              .toString(),
                          onChanged: (value) => onRepCountChange(index, value),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        settings.translations.reps,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: 90,
                            child: TextFormField(
                              key: Key(
                                '${exercise.workoutSets[index].id}_weight',
                              ),
                              controller: weightController,
                              onChanged: (value) =>
                                  onWeightChange(index, value),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            exercise.weightUnit.name,
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        settings.translations.weight,
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => removeSet(exercise.workoutSets[index]),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
