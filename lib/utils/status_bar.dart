import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/progress_bar.dart';
import 'package:provider/provider.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<WorkoutLog> workoutLogs = context
        .read<DataProvider>()
        .getWorkoutLogsFromThisWeek();

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                context.read<SettingsProvider>().translations.workoutProgress(
                  workoutLogs.length,
                  context.read<DataProvider>().plans.length,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 8,
                      child: ProgressBar(
                        value: workoutLogs.length.toDouble(),
                        maxValue: context
                            .read<DataProvider>()
                            .plans
                            .length
                            .toDouble(),
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
