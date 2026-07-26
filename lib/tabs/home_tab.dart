import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/appBars/home_tab_app_bar.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/next_workout.dart';
import 'package:gym_app/utils/recent_workouts.dart';
import 'package:gym_app/utils/status_bar.dart';
import 'package:gym_app/utils/workout_calendar.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // provide settings and app data using providers

    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settingModelValues, dataModelValues, child) =>
          CustomScrollView(
            slivers: [
              HomeTabAppBar(),
              SliverPadding(
                padding: const EdgeInsets.all(15),
                sliver: SliverList.list(
                  children: [
                    // show next workout plan if there any created
                    if (dataModelValues.plans.isNotEmpty)
                      CustomCard(
                        title: settingModelValues.translations.nextWorkout,
                        children: [NextWorkout()],
                      ),

                    MyDivider(),
                    // workout calendar card
                    CustomCard(
                      title: settingModelValues.translations.thisWeek,
                      children: [WorkoutCalendar(), StatusBar()],
                    ),

                    MyDivider(),
                    // show recent workout logs card if there were any completed
                    if (dataModelValues.getWorkoutLogsFromThisWeek().isNotEmpty)
                      CustomCard(
                        title: settingModelValues.translations.recentWorkouts,
                        children: [RecentWorkouts()],
                      ),
                    TextButton(
                      onPressed: () {
                        List<WorkoutLog> workoutLogs = context
                            .read<DataProvider>()
                            .workoutLogs;
                        for (WorkoutLog workoutLog in workoutLogs) {
                          context.read<DataProvider>().removeLog(workoutLog);
                        }
                      },
                      child: Text("Wyczyść logi"),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
