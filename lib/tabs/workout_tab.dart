import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/exercise_tab.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/exercise_card.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/workout_clock.dart';
import 'package:gym_app/utils/workout_timer.dart';
import 'package:provider/provider.dart';

class WorkoutTab extends StatefulWidget {
  final Plan plan;
  final WorkoutLog? logToEdit;
  const WorkoutTab({super.key, required this.plan, this.logToEdit});

  @override
  State<WorkoutTab> createState() => _WorkoutTabState();
}

class _WorkoutTabState extends State<WorkoutTab> {
  late Plan _copiedPlan;

  @override
  void initState() {
    super.initState();
    _copiedPlan = widget.plan.copy();
  }

  // remove exercise from current workout
  void _removeExercise(Exercise exercise) {
    setState(() {
      _copiedPlan.exercises.remove(exercise);
    });
  }

  // change exercise order in workout plan
  void _changeExerciseOrder(Exercise exercise, bool up) {
    int index = _copiedPlan.exercises.indexOf(exercise);
    int indexDestination = index;

    switch (up) {
      case true:
        indexDestination--;
        break;
      case false:
        indexDestination++;
        break;
    }

    if (!mounted || index == -1) return;

    setState(() {
      _copiedPlan.exercises.remove(exercise);
      _copiedPlan.exercises.insert(indexDestination, exercise);
    });
  }

  void _refreshWorkoutTabWidget() {
    setState(() {});
  }

  void _showFinishWorkoutPopup(BuildContext appContext) {
    showDialog(
      context: context,
      builder: (context) => Consumer<SettingsProvider>(
        builder: (context, settingsModelValues, child) => MyAlertDialog(
          title: widget.logToEdit != null
              ? settingsModelValues
                    .translations
                    .areYouSureWantToUpdateThisWorkout
              : settingsModelValues.translations.areYouSureYouWantToEnd,
          description: "",
          buttons: [
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);

                switch (widget.logToEdit == null) {
                  case true:
                    _logWorkout();
                    break;
                  case false:
                    _updateWorkout();
                    break;
                }

                if (widget.plan.isDifferent(_copiedPlan)) {
                  _showUpdatePlanPopup();
                } else {
                  Navigator.pop(appContext);
                }
              },
              label: Text(
                settingsModelValues.translations.yes,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              icon: const Icon(Icons.check, color: Colors.white),
            ),
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              label: Text(
                settingsModelValues.translations.no,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              icon: const Icon(Icons.close, color: Colors.white),
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
      ),
    );
  }

  void _logWorkout() {
    print('Logging workout');
    context.read<DataProvider>().addLog(_copiedPlan);
  }

  void _updateWorkout() {
    if (widget.logToEdit == null) return;

    context.read<DataProvider>().editLog(
      widget.logToEdit!.copyWith(plan: _copiedPlan),
    );
  }

  void _showUpdatePlanPopup() {
    BuildContext appContext = context;

    showDialog(
      context: context,
      builder: (context) => Consumer<SettingsProvider>(
        builder: (context, settingsModelValues, child) => MyAlertDialog(
          title:
              settingsModelValues.translations.doYouWantToSaveChangesToYourPlan,
          buttons: [
            TextButton.icon(
              onPressed: () {
                _updatePlan();
                Navigator.pop(context);
              },
              label: Text(
                settingsModelValues.translations.yes,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              icon: const Icon(Icons.check, color: Colors.white),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(appContext);
              },
              label: Text(
                settingsModelValues.translations.no,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              icon: const Icon(Icons.close, color: Colors.white),
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
      ),
    );
  }

  void _updatePlan() {
    context.read<DataProvider>().editPlan(_copiedPlan);
    Navigator.pop(context);
  }

  void _goBackAndUpdateActiveWorkout() {
    DataProvider dataModelValues = context.read<DataProvider>();

    if (dataModelValues.activeWorkout != null) {
      dataModelValues.updateActiveWorkout(_copiedPlan);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settingsModelValues, dataModelValues, child) =>
          CustomScrollView(
            slivers: [
              // app bar
              MyAppBar(
                title: _copiedPlan.name,
                leading: GestureDetector(
                  onTap: _goBackAndUpdateActiveWorkout,
                  child: Icon(Icons.arrow_back),
                ),
                actions: [
                  IconButton(
                    onPressed: () => _showFinishWorkoutPopup(context),
                    icon: Icon(Icons.check, size: 30),
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.all(0)),
                      backgroundColor: WidgetStateProperty.all(Colors.red),
                    ),
                  ),
                ],
              ),

              SliverPadding(
                padding: const EdgeInsets.all(15),
                sliver: SliverList.list(
                  children: [
                    // toolbar
                    if (widget.logToEdit == null)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            spacing: 15,
                            children: [
                              if (dataModelValues.activeWorkout != null)
                                WorkoutClock(
                                  activeWorkout: dataModelValues.activeWorkout!,
                                ),
                              WorkoutTimer(),
                            ],
                          ),
                        ),
                      ),

                    MyDivider(),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        Exercise exercise = _copiedPlan.exercises[index];

                        return GestureDetector(
                          // navigate to exercise tab
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ExerciseTab(
                                exercise: exercise,
                                refreshWorkoutTabWidget:
                                    _refreshWorkoutTabWidget,
                              ),
                            ),
                          ),
                          child: ExerciseCard(
                            exercise: exercise,
                            removeExercise: _removeExercise,
                            changeOrder: _changeExerciseOrder,
                            isFirst: index == 0,
                            isLast: index == _copiedPlan.exercises.length - 1,
                            showSets: true,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => MyDivider(),
                      itemCount: _copiedPlan.exercises.length,
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
