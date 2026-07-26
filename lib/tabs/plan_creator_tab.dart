import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/tabs/exercise_search_tab.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/exercise_card.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/my_icon.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

enum Direction { up, down }

class PlanCreatorTab extends StatefulWidget {
  final Plan? planToEdit;
  const PlanCreatorTab({super.key, this.planToEdit});

  @override
  State<PlanCreatorTab> createState() => _PlanCreatorTabState();
}

class _PlanCreatorTabState extends State<PlanCreatorTab> {
  String _iconName = FontAwesomeIcons.dumbbell.toString();
  String _name = "";
  List<Exercise> _exercises = <Exercise>[];
  late Plan? _copiedPlanToEdit;

  Widget _icon = FaIcon(FontAwesomeIcons.dumbbell);

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

    context.read<DataProvider>().addPlan(
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

    context.read<DataProvider>().editPlan(
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
                  onTap: () => _changeIcon(
                    FontAwesomeIcons.dumbbell.toString(),
                    context,
                  ),
                  child: MyIcon(
                    size: 10,
                    icon: FaIcon(FontAwesomeIcons.dumbbell),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      _changeIcon(Icons.sports_baseball.toString(), context),
                  child: MyIcon(size: 10, icon: Icon(Icons.sports_baseball)),
                ),
                GestureDetector(
                  onTap: () => _changeIcon(Icons.sports.toString(), context),
                  child: MyIcon(size: 10, icon: Icon(Icons.sports)),
                ),
                GestureDetector(
                  onTap: () =>
                      _changeIcon(Icons.sports_gymnastics.toString(), context),
                  child: MyIcon(size: 10, icon: Icon(Icons.sports_gymnastics)),
                ),
                GestureDetector(
                  onTap: () =>
                      _changeIcon(Icons.sports_mma.toString(), context),
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


  @override
  Widget build(BuildContext context) {
    return Consumer2(
      builder: (context, settingsModelValues, dataModelValues, child) =>
          Scaffold(
            appBar: AppBar(
              title: Text("Plan creator"),
              leading: IconButton(
                onPressed: () => closeWithoutSaving(context),
                icon: Icon(Icons.arrow_back),
              ),
              actions: [
                // submit plan
                IconButton(
                  onPressed: () => widget.planToEdit != null
                      ? _editPlan(context)
                      : _addPlan(context),
                  icon: Icon(Icons.check, size: 30),
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.all(0)),
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  Text("Icon"),

                  MyDivider(),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: _showChangeIconDialog,
                        child: MyIcon(size: 150, icon: _icon),
                      ),
                    ],
                  ),

                  MyDivider(),

                  Text("Name"),

                  MyDivider(),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextFormField(
                      initialValue: widget.planToEdit?.name,
                      textAlignVertical: TextAlignVertical.center,
                      enableSuggestions: false,
                      onChanged: (value) => _name = value,
                      decoration: InputDecoration(
                        hintText: "Enter a name for your workout plan",
                        suffixIcon: Icon(Icons.abc),
                      ),
                    ),
                  ),

                  MyDivider(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Exercises"),
                      IconButton(
                        onPressed: _addExercise,
                        icon: Icon(Icons.add, color: AppTheme.red),
                      ),
                    ],
                  ),

                  MyDivider(),

                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: _exercises.length,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => MyDivider(),
                    itemBuilder: (context, index) => ExerciseCard(
                      exercise: _exercises[index],
                      removeExercise: _removeExercise,
                      isFirst: index == 0,
                      isLast: index == _exercises.length - 1,
                      changeOrder: _changeExerciseOrder,
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
