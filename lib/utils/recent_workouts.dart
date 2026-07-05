import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/my_icon.dart';
import 'package:provider/provider.dart';

class RecentWorkouts extends StatelessWidget {
  const RecentWorkouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settingsModelValues, dataModelValues, child) =>
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: clampDouble(
              dataModelValues.workoutLogs.length.toDouble(),
              0,
              3,
            ).toInt(),
            itemBuilder: (context, index) {
              List<WorkoutLog> recentWorkouts = dataModelValues
                  .workoutLogs
                  .reversed
                  .toList();

              WorkoutLog workoutLog = recentWorkouts.elementAt(index);

              return Row(
                spacing: 15,
                children: [
                  const MyIcon(
                    size: 40,
                    icon: FaIcon(FontAwesomeIcons.dumbbell),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workoutLog.plan.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '${settingsModelValues.translations.formattedDate(workoutLog.dateTime)} | ${workoutLog.plan.exercises.length} ${settingsModelValues.translations.exercises}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Divider(
                thickness: .5,
                height: 3,
                color: Theme.of(context).focusColor,
              ),
            ),
          ),
    );
  }
}
