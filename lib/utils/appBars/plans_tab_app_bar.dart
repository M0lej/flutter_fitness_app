import 'package:flutter/material.dart';
import 'package:gym_app/settings/languages/translations.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/plan_creator_tab.dart';
import 'package:provider/provider.dart';

class PlansTabAppBar extends StatelessWidget {
  const PlansTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    Translations translations = context.watch<SettingsProvider>().translations;

    return SliverSafeArea(
      sliver: SliverAppBar(
        actionsPadding: const EdgeInsets.only(right: 5),
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            translations.plans,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        floating: true,
        pinned: false,
        flexibleSpace: FlexibleSpaceBar(
          background: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        actions: [
          // create new plan
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlanCreatorTab()),
            ),
            icon: Icon(Icons.add, size: 30),
            style: ButtonStyle(
              padding: WidgetStateProperty.all(EdgeInsets.all(0)),
              backgroundColor: WidgetStateProperty.all(Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
