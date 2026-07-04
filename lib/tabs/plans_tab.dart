import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/appBars/plans_tab_app_bar.dart';
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
      builder: (context, settingsModelValues, dataModelValues, child) =>
          CustomScrollView(
            slivers: [
              PlansTabAppBar(),
              SliverPadding(
                padding: const EdgeInsets.all(15),
                sliver: SliverList.list(
                  children: [
                    Text(
                      settingsModelValues.translations.yourPlans,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 13,
                      ),
                    ),

                    MyDivider(),

                    ListView.separated(
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dataModelValues.plans.length,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => MyDivider(),
                      itemBuilder: (context, index) {
                        Plan currentPlan = dataModelValues.plans[index];

                        return PlanCard(plan: currentPlan);
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
