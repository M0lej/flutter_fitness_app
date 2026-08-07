import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/config.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/plan_creator_tab.dart';
import 'package:gym_app/tabs/workout_tab.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/animated_card.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/my_icon.dart';
import 'package:provider/provider.dart';

class AnimatedPlanListItem extends StatefulWidget {
  final DataProvider appData;
  final SettingsProvider settings;

  final Plan plan;

  final int index;

  const AnimatedPlanListItem({
    super.key,
    required this.plan,
    required this.appData,
    required this.settings,
    required this.index,
  });

  @override
  State<AnimatedPlanListItem> createState() => _AnimatedPlanListItemState();
}

class _AnimatedPlanListItemState extends State<AnimatedPlanListItem> {
  bool _propertiesExpanded = false;

  // show / hide properties
  void _switchPropertiesPanel() {
    setState(() {
      _propertiesExpanded = !_propertiesExpanded;
    });
  }

  // show deletion popup and remove workout plan if submitted
  void _deletePlan() {
    showDialog(
      context: context,
      builder: (context) => MyAlertDialog(
        title:
            '${widget.settings.translations.areYouSureYouWantToDeletePlan} "${widget.plan.name}" ?',
        description:
            '\n\n${widget.settings.translations.thisActionCannotBeUndone}',
        buttons: [
          TextButton.icon(
            onPressed: () {
              widget.appData.removePlan(widget.plan);
              Navigator.pop(context);
            },
            label: Text(
              widget.settings.translations.delete,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            icon: const Icon(Icons.delete_forever, color: Colors.white),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            label: Text(
              widget.settings.translations.cancel,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            icon: const Icon(Icons.cancel, color: Colors.white),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Theme.of(context).cardTheme.color,
              ),
              side: WidgetStateProperty.all(
                const BorderSide(color: AppTheme.borderColor),
              ),
            ),
          ),
        ],
      ),
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
    WorkoutLog? activeWorkout = context.read<DataProvider>().activeWorkout;

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

    context.read<DataProvider>().addActiveWorkout(widget.plan);

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

                // MENU BUTTON
                IconButton(
                  onPressed: _switchPropertiesPanel,
                  icon: const Icon(Icons.more_horiz),
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

            // EXPANDED ACTIONS
            if (_propertiesExpanded)
              Row(
                spacing: 10,
                children: [
                  TextButton.icon(
                    onPressed: _deletePlan,
                    icon: const Icon(Icons.delete_forever, color: Colors.white),
                    label: Text(
                      widget.settings.translations.delete,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: _editPlan,
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(
                      widget.settings.translations.edit,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).cardTheme.color,
                      ),
                      side: WidgetStateProperty.all(
                        BorderSide(color: AppTheme.borderColor),
                      ),
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
