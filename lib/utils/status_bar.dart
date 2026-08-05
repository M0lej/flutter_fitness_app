import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/progress_bar.dart';

class StatusBar extends StatelessWidget {
  final SettingsProvider settings;
  final DataProvider appData;
  const StatusBar({super.key, required this.settings, required this.appData});

  @override
  Widget build(BuildContext context) {
    List<WorkoutLog> workoutLogs = appData.getWorkoutLogsFromThisWeek();

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                settings.translations.workoutProgress(
                  workoutLogs.length,
                  settings.weekWorkoutsGoal,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 8,
                      child: ProgressBar(
                        value: workoutLogs.length,
                        maxValue: settings.weekWorkoutsGoal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
