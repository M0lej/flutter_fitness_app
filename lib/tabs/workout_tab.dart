import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/serie.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/exercise_tab.dart';
import 'package:gym_app/utils/exercise_card.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:provider/provider.dart';

class WorkoutTab extends StatefulWidget {
  final Plan plan;
  const WorkoutTab({super.key, required this.plan});

  @override
  State<WorkoutTab> createState() => _WorkoutTabState();
}

class _WorkoutTabState extends State<WorkoutTab> {
  // remove exercise from current workout
  void _removeExercise(Exercise exercise) {
    setState(() {
      widget.plan.exercises.remove(exercise);
    });
  }

  // change exercise order in workout plan
  void _changeExerciseOrder(Exercise exercise, bool up) {
    int index = widget.plan.exercises.indexOf(exercise);
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
      widget.plan.exercises.remove(exercise);
      widget.plan.exercises.insert(indexDestination, exercise);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settingsModelValues, dataModelValues, child) =>
          CustomScrollView(
            slivers: [
              SliverAppBar(title: Text(widget.plan.name)),
              SliverPadding(
                padding: const EdgeInsets.all(15),
                sliver: SliverList.list(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Exercise exercise = widget.plan.exercises[index];
                        exercise.series = [
                          Serie(reps: 12, weight: 20),
                          Serie(reps: 8, weight: 20),
                          Serie(reps: 9, weight: 20),
                          Serie(reps: 8, weight: 20),
                        ];

                        return GestureDetector(
                          // navigate to exercise tab
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ExerciseTab(exercise: exercise),
                            ),
                          ),
                          child: ExerciseCard(
                            exercise: exercise,
                            removeExercise: _removeExercise,
                            changeOrder: _changeExerciseOrder,
                            isFirst: index == 0,
                            isLast: index == widget.plan.exercises.length - 1,
                            showSeries: true,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => MyDivider(),
                      itemCount: widget.plan.exercises.length,
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
