import 'package:flutter/material.dart';
import 'package:gym_app/tabs/exercise_search_tab.dart';
import 'package:gym_app/themes/app_theme.dart';

class ExerciseSearchTabSwitchButton extends StatelessWidget {
  final Function(ExercisesSource) changeExercisesSource;
  final ExercisesSource exercisesSource;
  final ExercisesSource thisExerciseSource;
  final String labelText;

  const ExerciseSearchTabSwitchButton({
    super.key,
    required this.changeExercisesSource,
    required this.exercisesSource,
    required this.labelText,
    required this.thisExerciseSource,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton.icon(
        onPressed: () => changeExercisesSource(thisExerciseSource),
        label: Text(
          labelText,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        icon: const Icon(Icons.book),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            exercisesSource == thisExerciseSource
                ? AppTheme.red
                : Theme.of(context).cardTheme.color,
          ),
        ),
      ),
    );
  }
}
