import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/app_tabs_controller.dart';
import 'package:gym_app/tabs/workout_tab.dart';

class NextWorkout extends StatelessWidget {
  final DataProvider appData;
  final SettingsProvider settings;
  const NextWorkout({super.key, required this.appData, required this.settings});

  @override
  Widget build(BuildContext context) {
    Plan? nextWorkoutPlan = appData.getNextWorkoutPlan();

    bool workoutQuotaCompleted = nextWorkoutPlan == null;

    if (workoutQuotaCompleted) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            settings.translations.allPlansHaveBeenCompleted,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            settings.translations.continueMessage,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => changeTab(1, context),
                    label: Text(
                      settings.translations.selectWorkout,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_right),
                    iconAlignment: IconAlignment.end,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    String primaryMusclesString = nextWorkoutPlan.exercises
        .map((Exercise exercise) => exercise.primaryMuscles?.join(', '))
        .join(', ');

    void startWorkout() {
      if (appData.activeWorkout == null) {
        appData.addActiveWorkout(nextWorkoutPlan);
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutTab(
            plan: nextWorkoutPlan,
            settings: settings,
            appData: appData,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        AutoSizeText(
          nextWorkoutPlan.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          minFontSize: 20,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          '${nextWorkoutPlan.exercises.length} ${settings.translations.exercises(nextWorkoutPlan.exercises.length)}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 12,
          ),
        ),

        // primary muscles
        Row(
          spacing: 5,
          children: [
            nextWorkoutPlan.icon,
            Expanded(
              child: AutoSizeText(
                primaryMusclesString,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: startWorkout,
                  label: Text(
                    appData.activeWorkout != null
                        ? settings.translations.workoutContinue
                        : settings.translations.startWorkout,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  icon: Icon(Icons.keyboard_arrow_right),
                  iconAlignment: IconAlignment.end,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
