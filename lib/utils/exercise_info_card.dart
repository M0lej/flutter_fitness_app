import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/exercise_preview_tab.dart';
import 'package:gym_app/utils/animated_card.dart';
import 'package:gym_app/utils/my_image.dart';

class ExerciseInfoCard extends StatelessWidget {
  final int index;
  final Exercise exercise;
  final SettingsProvider settings;
  final Function(Exercise) addExercise;
  const ExerciseInfoCard({
    super.key,
    required this.index,
    required this.exercise,
    required this.addExercise,
    required this.settings,
  });

  void _navigateToExerciseDescription(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ExercisePreviewTab(exercise: exercise, settings: settings),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToExerciseDescription(context),
      child: AnimatedCard(
        index: index,
        indexDelayedAnimation: false,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
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
                      maxFontSize: 15,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
                    ),
                    AutoSizeText(
                      [
                        ...exercise.primaryMuscles ?? [],
                        ...exercise.secondaryMuscles ?? [],
                      ].join(", "),
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => addExercise(exercise),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
