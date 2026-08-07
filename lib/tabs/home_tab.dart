import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/appBars/home_tab_app_bar.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/next_workout.dart';
import 'package:gym_app/utils/recent_workouts.dart';
import 'package:gym_app/utils/stats_card/stats_card.dart';
import 'package:gym_app/utils/status_bar.dart';
import 'package:gym_app/utils/workout_calendar.dart';

class HomeTab extends StatelessWidget {
  final SettingsProvider settings;
  final DataProvider appData;
  const HomeTab({super.key, required this.settings, required this.appData});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const HomeTabAppBar(),
        SliverPadding(
          padding: const EdgeInsets.all(15),
          sliver: SliverList.list(
            children: [
              // show next workout plan if there any created
              if (appData.plans.isNotEmpty)
                Column(
                  children: [
                    CustomCard(
                      index: 0,
                      title: settings.translations.nextWorkout,
                      children: [
                        NextWorkout(appData: appData, settings: settings),
                      ],
                    ),
                    const MyDivider(),
                  ],
                ),

              // workout calendar card
              CustomCard(
                index: 1,
                title: settings.translations.thisWeek,
                children: [
                  WorkoutCalendar(appData: appData, settings: settings),
                  StatusBar(appData: appData, settings: settings),
                ],
              ),

              const MyDivider(),
              // show recent workout logs card if there were any completed
              if (appData.getWorkoutLogsFromThisWeek().isNotEmpty)
                Column(
                  children: [
                    CustomCard(
                      index: 2,
                      title: settings.translations.recentWorkouts,
                      children: [
                        RecentWorkouts(appData: appData, settings: settings),
                      ],
                    ),
                    const MyDivider(),
                  ],
                ),

              // stats
              CustomCard(
                index: 3,
                title: settings.translations.progressOverview,
                children: [Stats(appData: appData, settings: settings)],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
