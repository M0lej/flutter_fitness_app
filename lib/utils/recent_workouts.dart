import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/workout_tab.dart';
import 'package:gym_app/utils/my_icon.dart';

class RecentWorkouts extends StatelessWidget {
  final SettingsProvider settings;
  final DataProvider appData;
  const RecentWorkouts({
    super.key,
    required this.settings,
    required this.appData,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: clampDouble(
        appData.workoutLogs.length.toDouble(),
        0,
        3,
      ).toInt(),
      itemBuilder: (context, index) {
        final List<WorkoutLog> recentWorkouts = appData.workoutLogs.reversed
            .toList();

        final WorkoutLog workoutLog = recentWorkouts.elementAt(index);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutTab(
                plan: workoutLog.plan,
                logToEdit: workoutLog,
                settings: settings,
                appData: appData,
              ),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                spacing: 15,
                children: [
                  MyIcon(size: 40, icon: workoutLog.plan.icon),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workoutLog.plan.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              '${settings.translations.formattedDate(workoutLog.end!)} | ${workoutLog.plan.exercises.length} ${settings.translations.exercises(workoutLog.plan.exercises.length)}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
    );
  }
}
