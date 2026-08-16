import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/plan_creator_tab.dart';
import 'package:gym_app/tabs/workout_tab.dart';
import 'package:gym_app/utils/animated_card.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/my_icon.dart';

class PlanCard extends StatefulWidget {
  final DataProvider appData;
  final SettingsProvider settings;

  final Plan plan;

  final int index;

  const PlanCard({
    super.key,
    required this.plan,
    required this.appData,
    required this.settings,
    required this.index,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  // show deletion popup and remove workout plan if submitted
  void _deletePlan() {
    showYesNoDialog(
      title:
          '${widget.settings.translations.areYouSureYouWantToDeletePlan} "${widget.plan.name}" ?',
      description:
          '\n\n${widget.settings.translations.thisActionCannotBeUndone}',
      onYes: () => widget.appData.removePlan(widget.plan),
      appContext: context,
      translations: widget.settings.translations,
    );
  }

  // navigate to plan creator tab with current plan provided
  void _editPlan() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanCreatorTab(
          planToEdit: widget.plan,
          appData: widget.appData,
          settings: widget.settings,
        ),
      ),
    );
  }

  // if there isn't an active workout then start a new one and navigate to workout tab
  void _goToWorkoutTab() {
    WorkoutLog? activeWorkout = widget.appData.activeWorkout;

    if (activeWorkout != null) {
      showDialog(
        context: context,
        builder: (context) => MyAlertDialog(
          title: widget.settings.translations.onlyOneSessionTitle,
          description: widget.settings.translations.onlyOneSessionDesc(
            activeWorkout.plan.name,
          ),
          buttons: [
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              label: Text(
                "Ok",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      );
      return;
    }

    widget.appData.addActiveWorkout(widget.plan);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutTab(
          plan: widget.plan,
          settings: widget.settings,
          appData: widget.appData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      index: widget.index,
      onLongPress: () => _deletePlan(),
      onTap: () => _editPlan(),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 15,
          children: [
            // TOP ROW: icon + text + button
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyIcon(size: 100, icon: widget.plan.icon),

                const SizedBox(width: 20),

                // TEXT AREA
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      AutoSizeText(
                        widget.plan.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        maxFontSize: 20,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      Text(
                        '${widget.plan.exercises.length} ${widget.settings.translations.exercises(widget.plan.exercises.length)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: _goToWorkoutTab,
                  icon: const Icon(Icons.play_arrow),
                ),
              ],
            ),

            // DIVIDER
            Divider(
              thickness: 0.5,
              height: 1,
              color: Theme.of(context).focusColor,
            ),

            // DATE ROW
            Row(
              spacing: 5,
              children: [
                const Icon(Icons.calendar_month_outlined, size: 20),
                Expanded(
                  child: Text(
                    '${widget.settings.translations.created} '
                    '${widget.settings.translations.formattedDate(widget.plan.creationDate)} '
                    '${widget.plan.creationDate.year}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
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
