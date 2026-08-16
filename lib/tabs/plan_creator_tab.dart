import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/exercise_preview_tab.dart';
import 'package:gym_app/tabs/exercise_search_tab.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/exercise_card/exercise_card.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/my_icon.dart';
import 'package:uuid/uuid.dart';

enum Direction { up, down }

class PlanCreatorTab extends StatefulWidget {
  final SettingsProvider settings;
  final DataProvider appData;

  final Plan? planToEdit;
  const PlanCreatorTab({
    super.key,
    this.planToEdit,
    required this.appData,
    required this.settings,
  });

  @override
  State<PlanCreatorTab> createState() => _PlanCreatorTabState();
}

class _PlanCreatorTabState extends State<PlanCreatorTab> {
  String _iconName = 'dumbbell';
  String _name = "";
  List<Exercise> _exercises = <Exercise>[];
  late Plan? _copiedPlanToEdit;

  Widget _icon = const FaIcon(FontAwesomeIcons.dumbbell);

  @override
  void initState() {
    if (widget.planToEdit != null) {
      _copiedPlanToEdit = widget.planToEdit!.copy();

      _exercises = _copiedPlanToEdit!.exercises;
      _name = _copiedPlanToEdit!.name;
      _iconName = _copiedPlanToEdit!.iconName;

      _icon = _copiedPlanToEdit!.icon;
    }
    super.initState();
  }

  void _addExercise() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseSearchTab(
          appData: widget.appData,
          settings: widget.settings,
          excludedExercisesIds: _exercises.map((Exercise ex) => ex.id),
          addExercise: (Exercise exercise) {
            setState(() {
              _exercises.add(exercise);
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _removeExercise(Exercise exercise) {
    setState(() {
      _exercises.remove(exercise);
    });
  }

  void _changeExerciseOrder(Exercise exercise, bool up) {
    int index = _exercises.indexOf(exercise);
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
      _exercises.remove(exercise);
      _exercises.insert(indexDestination, exercise);
    });
  }

  void _addPlan(BuildContext context) {
    if (_exercises.isEmpty || _name.isEmpty || _iconName.isEmpty) return;

    String uuid = Uuid().v1().toString();

    widget.appData.addPlan(
      Plan(
        name: _name,
        exercises: _exercises,
        creationDate: DateTime.now(),
        iconName: _iconName,
        id: uuid,
      ),
    );
    Navigator.pop(context);
  }

  void _editPlan(BuildContext context) {
    if (_exercises.isEmpty || _name.isEmpty || widget.planToEdit == null) {
      return;
    }

    widget.appData.editPlan(
      Plan(
        name: _name,
        exercises: _exercises,
        creationDate: DateTime.now(),
        iconName: _iconName,
        id: widget.planToEdit!.id,
      ),
    );
    Navigator.pop(context);
  }

  void _showChangeIconDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(height: 250),
          child: Card(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              padding: EdgeInsets.all(15),
              children: [
                GestureDetector(
                  onTap: () => _changeIcon('dumbbell', context),
                  child: MyIcon(
                    size: 10,
                    icon: FaIcon(FontAwesomeIcons.dumbbell),
                  ),
                ),
                GestureDetector(
                  onTap: () => _changeIcon('sports_baseball', context),
                  child: MyIcon(size: 10, icon: Icon(Icons.sports_baseball)),
                ),
                GestureDetector(
                  onTap: () => _changeIcon('sports', context),
                  child: MyIcon(size: 10, icon: Icon(Icons.sports)),
                ),
                GestureDetector(
                  onTap: () => _changeIcon('sports_gymnastics', context),
                  child: MyIcon(size: 10, icon: Icon(Icons.sports_gymnastics)),
                ),
                GestureDetector(
                  onTap: () => _changeIcon('sports_mma', context),
                  child: MyIcon(size: 10, icon: Icon(Icons.sports_mma)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeIcon(String iconName, BuildContext dialogContext) {
    _iconName = iconName;

    setState(() {
      _icon = getIconWidgetByName(iconName);
    });
    Navigator.pop(dialogContext);
  }

  void _navigateToExerciseDescription(BuildContext context, Exercise exercise) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ExercisePreviewTab(exercise: exercise, settings: widget.settings),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.backgroundBlack,
      child: CustomScrollView(
        slivers: [
          MyAppBar(
            title: widget.settings.translations.planCreator,
            actions: [
              IconButton(
                onPressed: () => widget.planToEdit != null
                    ? _editPlan(context)
                    : _addPlan(context),
                icon: const Icon(Icons.check, size: 30),
              ),
            ],
            leading: IconButton(
              onPressed: () => closeWithoutSaving(appContext: context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList.list(
              children: [
                Text(widget.settings.translations.icon),

                const MyDivider(),

                Row(
                  children: [
                    GestureDetector(
                      onTap: _showChangeIconDialog,
                      child: MyIcon(size: 150, icon: _icon),
                    ),
                  ],
                ),

                const MyDivider(),

                Text(widget.settings.translations.name),

                const MyDivider(),

                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextFormField(
                    initialValue: widget.planToEdit?.name,
                    textAlignVertical: TextAlignVertical.center,
                    enableSuggestions: false,
                    onChanged: (value) => _name = value,
                    decoration: InputDecoration(
                      hintText: widget
                          .settings
                          .translations
                          .enterANameForYourWorkoutPlan,
                      suffixIcon: const Icon(Icons.abc),
                    ),
                  ),
                ),

                const MyDivider(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.settings.translations.exercises2),
                    IconButton(
                      onPressed: _addExercise,
                      icon: const Icon(Icons.add, color: AppTheme.red),
                    ),
                  ],
                ),

                const MyDivider(),

                ListView.separated(
                  shrinkWrap: true,
                  itemCount: _exercises.length,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => MyDivider(),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => _navigateToExerciseDescription(
                      context,
                      _exercises[index],
                    ),
                    child: ExerciseCard(
                      exercise: _exercises[index],
                      removeExercise: _removeExercise,
                      isFirst: index == 0,
                      isLast: index == _exercises.length - 1,
                      changeOrder: _changeExerciseOrder,
                      translations: widget.settings.translations,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
