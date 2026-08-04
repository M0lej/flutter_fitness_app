import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/month_stats.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/stats_card/stats_card_item.dart';

class StatsCard extends StatelessWidget {
  final DataProvider appData;
  final SettingsProvider settings;

  const StatsCard({super.key, required this.appData, required this.settings});

  int _getPercentageValue(List<MonthStats> monthsStats) {
    if (monthsStats.isEmpty) return 0;
    if (monthsStats.length == 1) return 100;

    int difference = monthsStats.last.score - monthsStats.first.score;

    int percentage = ((difference / monthsStats.first.score) * 100).round();

    return percentage;
  }

  String _formatPercentageValue(int percentageValue) =>
      percentageValue >= 0 ? "+$percentageValue%" : '$percentageValue%';

  @override
  Widget build(BuildContext context) {
    int percentageValue = _getPercentageValue(appData.monthsStats);

    return CustomCard(
      title: settings.translations.progressOverview,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatsCardItem(
              value: appData.completedWorkoutsCount.toString(),
              labelText: settings.translations.workouts,
              icon: const FaIcon(FontAwesomeIcons.dumbbell),
            ),
            StatsCardItem(
              value: _formatPercentageValue(percentageValue),
              labelText: settings.translations.vsLastMonth,
              icon: Icon(
                percentageValue == 0
                    ? Icons.trending_flat
                    : percentageValue > 0
                    ? Icons.trending_up
                    : Icons.trending_down,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
