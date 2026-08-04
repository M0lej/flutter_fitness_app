import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/appBars/home_tab_app_bar.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/next_workout.dart';
import 'package:gym_app/utils/recent_workouts.dart';
import 'package:gym_app/utils/stats_card/stats_card.dart';
import 'package:gym_app/utils/status_bar.dart';
import 'package:gym_app/utils/workout_calendar.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // provide settings and app data using providers

    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settings, appData, child) => CustomScrollView(
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
                        title: settings.translations.nextWorkout,
                        children: [NextWorkout()],
                      ),
                      const MyDivider(),
                    ],
                  ),

                // workout calendar card
                CustomCard(
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
                        title: settings.translations.recentWorkouts,
                        children: [RecentWorkouts()],
                      ),
                      const MyDivider(),
                    ],
                  ),

                // stats
                StatsCard(appData: appData, settings: settings),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
