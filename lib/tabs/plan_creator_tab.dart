import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/tabs/exercise_search_tab.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/exercise_card.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/my_icon.dart';
import 'package:provider/provider.dart';

enum Direction { up, down }

class PlanCreatorTab extends StatefulWidget {
  const PlanCreatorTab({super.key});

  @override
  State<PlanCreatorTab> createState() => _PlanCreatorTabState();
}

class _PlanCreatorTabState extends State<PlanCreatorTab> {
  FaIcon _icon = FaIcon(FontAwesomeIcons.dumbbell);
  String _name = "";
  List<Exercise> _exercises = <Exercise>[];

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

  @override
  Widget build(BuildContext context) {
    return Consumer2(
      builder: (context, settingsModelValues, dataModelValues, child) =>
          Scaffold(
            appBar: AppBar(title: Text("Plan creator")),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(
                children: [
                  Text("Icon"),

                  MyDivider(),

                  Row(
                    children: [
                      const MyIcon(
                        size: 150,
                        faIcon: FaIcon(FontAwesomeIcons.dumbbell),
                      ),
                    ],
                  ),

                  MyDivider(),

                  Text("Name"),

                  MyDivider(),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      enableSuggestions: false,
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
