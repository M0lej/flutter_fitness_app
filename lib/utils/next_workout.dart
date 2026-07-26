import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/app_tabs_controller.dart';
import 'package:gym_app/tabs/workout_tab.dart';
import 'package:provider/provider.dart';

class NextWorkout extends StatelessWidget {
  const NextWorkout({super.key});

  @override
  Widget build(BuildContext context) {
    Plan? nextWorkoutPlan = context.watch<DataProvider>().getNextWorkoutPlan();

    bool workoutQuotaCompleted = nextWorkoutPlan == null;

    if (workoutQuotaCompleted) {
      return Consumer<SettingsProvider>(
        builder: (context, settingsModelValues, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              settingsModelValues.translations.allPlansHaveBeenCompleted,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              settingsModelValues.translations.continueMessage,
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
                        settingsModelValues.translations.selectWorkout,
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
        ),
      );
    }

    String primaryMusclesString = nextWorkoutPlan.exercises
        .map((Exercise exercise) => exercise.primaryMuscles?.join(', '))
        .join(', ');

    void startWorkout() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutTab(plan: nextWorkoutPlan),
        ),
      );
    }

    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settingModelValues, dataModelValues, child) => Column(
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
            '${0} ${settingModelValues.translations.exercises}',
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
                      "Start workout",
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
      ),
    );
  }
}
