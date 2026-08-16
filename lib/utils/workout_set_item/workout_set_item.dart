import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/exercise_stats.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:gym_app/settings/languages/translations.dart';
import 'package:gym_app/utils/animated_card.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/workout_set_item/workout_set_item_input.dart';

class WorkoutSetItem extends StatefulWidget {
  final Exercise exercise;
  final int index;
  final Translations translations;
  final DataProvider appData;
  final Function(int, String) onRepCountChange;
  final Function(int, String) onWeightChange;
  final TextEditingController weightController;
  final Function(int) removeSet;

  final bool editMode;

  const WorkoutSetItem({
    super.key,
    required this.exercise,
    required this.index,
    required this.onRepCountChange,
    required this.onWeightChange,
    required this.translations,
    required this.weightController,
    required this.removeSet,
    required this.appData,
    this.editMode = false,
  });

  @override
  State<WorkoutSetItem> createState() => _WorkoutSetItemState();
}

class _WorkoutSetItemState extends State<WorkoutSetItem> {
  late ExerciseStats? exerciseStats;
  late WorkoutSet? previousWorkoutSetData;

  @override
  void initState() {
    super.initState();

    exerciseStats = widget.appData.getExerciseStatsWithId(widget.exercise.id);

    previousWorkoutSetData = exerciseStats?.lastWorkoutSets.elementAtOrNull(
      widget.index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutSetId = widget.exercise.workoutSets[widget.index].id;

    return AnimatedCard(
      index: widget.index,
      key: ValueKey(workoutSetId),
      onLongPress: () => showYesNoDialog(
        title: widget.translations.removeSet,
        onYes: () => widget.removeSet(widget.index),
        appContext: context,
        translations: widget.translations,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                spacing: 15,
                children: [
                  WorkoutSetItemInput(
                    exercise: widget.exercise,
                    index: widget.index,
                    onChange: widget.onRepCountChange,
                    inputType: InputType.reps,
                    translations: widget.translations,
                    initialValue: widget.exercise.workoutSets[widget.index].reps
                        .toString(),
                    last: widget.editMode ? null : previousWorkoutSetData?.reps,
                  ),
                  WorkoutSetItemInput(
                    exercise: widget.exercise,
                    index: widget.index,
                    onChange: widget.onWeightChange,
                    inputType: InputType.weight,
                    translations: widget.translations,
                    initialValue: widget
                        .exercise
                        .workoutSets[widget.index]
                        .weight
                        .toString(),
                    last: widget.editMode
                        ? null
                        : previousWorkoutSetData?.weight,
                    lastWeightUnit: widget.editMode
                        ? exerciseStats?.weightUnit
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
