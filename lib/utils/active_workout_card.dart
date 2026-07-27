import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/workout_tab.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/my_icon.dart';
import 'package:provider/provider.dart';

class ActiveWorkoutCard extends StatelessWidget {
  const ActiveWorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<DataProvider>().activeWorkout == null) {
      return SizedBox.shrink();
    }
    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settingsModelValues, dataModelValues, child) =>
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    WorkoutTab(plan: dataModelValues.activeWorkout!.plan),
              ),
            ),
            child: CustomCard(
              color: AppTheme.red,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyIcon(
                      size: 100,
                      icon: dataModelValues.activeWorkout!.plan.icon,
                    ),

                    const SizedBox(width: 20),

                    // TEXT AREA
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          AutoSizeText(
                            dataModelValues.activeWorkout!.plan.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            maxFontSize: 20,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),

                          Text(
                            '${dataModelValues.activeWorkout!.plan.exercises.length} ${settingsModelValues.translations.exercises}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
