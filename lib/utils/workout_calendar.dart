import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';

class WorkoutCalendar extends StatelessWidget {
  final DataProvider appData;
  final SettingsProvider settings;

  const WorkoutCalendar({
    super.key,
    required this.appData,
    required this.settings,
  });

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = DateTime.now().weekday - 1;
    final DateTime now = DateTime.now();

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // start counting days from the start of the week to the end
          DateTime date = now.add(Duration(days: -now.weekday + 1 + index));

          // check if the date that is displaying is today
          bool isSelected = selectedIndex == index;

          // style the text if the date is the same as today
          Color weekNameTextColor = isSelected
              ? Theme.of(context).highlightColor.withAlpha(200)
              : Theme.of(context).colorScheme.secondary;

          Color dateTextColor = isSelected
              ? Theme.of(context).highlightColor
              : Theme.of(context).colorScheme.primary;

          // get workouts that have been completed that day
          List<WorkoutLog> workoutLogs = appData.workoutLogs
              .where(
                (WorkoutLog workoutLog) =>
                    DateUtils.isSameDay(workoutLog.end, date),
              )
              .toList();

          // check if there was any workout completed
          bool didWorkoutThatDay = workoutLogs.isNotEmpty;

          return SizedBox(
            width: 55,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).focusColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Text(
                    settings.translations.weekDayNamesShort[date.weekday - 1],
                    style: TextStyle(fontSize: 10, color: weekNameTextColor),
                  ),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 17,
                      color: dateTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    didWorkoutThatDay
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: 7,
      ),
    );
  }
}
