import 'package:flutter/material.dart';
import 'package:gym_app/settings/languages/translations.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:provider/provider.dart';

class HomeTabAppBar extends StatelessWidget {
  const HomeTabAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final int hour = DateTime.now().hour;
    Translations translations = context.watch<SettingsProvider>().translations;

    return SliverSafeArea(
      sliver: SliverAppBar(
        actionsPadding: const EdgeInsets.only(right: 5),
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title based on the time
              Text(
                '${hour < 13
                    ? translations.goodAfternoon
                    : hour < 18
                    ? translations.goodAfternoon
                    : translations.goodEvening}, Max! 👋',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              // motivational message
              Text(
                translations.motivationText,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        floating: true,
        actions: [
          // settings
          IconButton(
            onPressed: () => print("ds"),
            icon: Icon(Icons.settings_outlined),
          ),

          //notifications
          IconButton(
            onPressed: () => print("ds"),
            icon: Icon(Icons.notifications_outlined),
          ),
        ],
      ),
    );
  }
}
