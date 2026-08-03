import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/plan_creator_tab.dart';
import 'package:gym_app/utils/active_workout_card.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/plan_card.dart';
import 'package:provider/provider.dart';

class PlansTab extends StatefulWidget {
  const PlansTab({super.key});

  @override
  State<PlansTab> createState() => _PlansTabState();
}

class _PlansTabState extends State<PlansTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settings, appData, child) => CustomScrollView(
        slivers: [
          // app bar
          MyAppBar(
            title: settings.translations.plans,
            actions: [
              IconButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanCreatorTab()),
                ),
                icon: const Icon(Icons.add, size: 30),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.all(0)),
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                ),
              ),
            ],
          ),

          // content padding
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList.list(
              children: [
                if (appData.activeWorkout != null)
                  Text(
                    settings.translations.activeWorkout,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 13,
                    ),
                  ),

                const MyDivider(),

                ActiveWorkoutCard(appData: appData, settings: settings),

                const MyDivider(),

                Text(
                  settings.translations.yourPlans,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 13,
                  ),
                ),

                const MyDivider(),

                ListView.separated(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appData.plans.length,
                  shrinkWrap: true,
                  separatorBuilder: (_, _) => MyDivider(),
                  itemBuilder: (context, index) {
                    Plan currentPlan = appData.plans[index];

                    return PlanCard(
                      plan: currentPlan,
                      appData: appData,
                      settings: settings,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
