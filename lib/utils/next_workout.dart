import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/settings/settings_provider.dart';
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
                      onPressed: () => print("test"),
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

    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settingModelValues, dataModelValues, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Text(
            nextWorkoutPlan.name,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            '${0} ${settingModelValues.translations.exercises}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12,
            ),
          ),
          Row(
            spacing: 5,
            children: [
              const FaIcon(FontAwesomeIcons.dumbbell, size: 15),
              Text(
                "Chest, Shoulders, Triceps",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
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
                    onPressed: () => print("test"),
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
