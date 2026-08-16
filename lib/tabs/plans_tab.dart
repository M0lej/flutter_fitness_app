import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/plan_creator_tab.dart';
import 'package:gym_app/utils/active_workout_card.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/plan_card.dart';

class PlansTab extends StatefulWidget {
  final SettingsProvider settings;
  final DataProvider appData;
  const PlansTab({super.key, required this.settings, required this.appData});

  @override
  State<PlansTab> createState() => _PlansTabState();
}

class _PlansTabState extends State<PlansTab> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // app bar
        MyAppBar(
          title: widget.settings.translations.plans,
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanCreatorTab(
                    appData: widget.appData,
                    settings: widget.settings,
                  ),
                ),
              ),
              icon: const Icon(Icons.add, size: 30),
            ),
          ],
        ),

        // content padding
        SliverPadding(
          padding: const EdgeInsets.all(15),
          sliver: SliverList.list(
            children: [
              if (widget.appData.activeWorkout != null)
                Text(
                  widget.settings.translations.activeWorkout,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 13,
                  ),
                ),

              const MyDivider(),

              ActiveWorkoutCard(
                appData: widget.appData,
                settings: widget.settings,
              ),

              const MyDivider(),

              Text(
                widget.settings.translations.yourPlans,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 13,
                ),
              ),

              const MyDivider(),

              ListView.separated(
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.appData.plans.length,
                shrinkWrap: true,
                separatorBuilder: (_, _) => MyDivider(),
                itemBuilder: (context, index) {
                  Plan currentPlan = widget.appData.plans[index];

                  return PlanCard(
                    plan: currentPlan,
                    appData: widget.appData,
                    settings: widget.settings,
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
