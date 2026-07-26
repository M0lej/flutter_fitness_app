import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/extensions/weight_extensions.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:uuid/uuid.dart';

class ExerciseTab extends StatefulWidget {
  final Exercise exercise;
  final Function refreshWorkoutTabWidget;
  const ExerciseTab({
    super.key,
    required this.exercise,
    required this.refreshWorkoutTabWidget,
  });

  @override
  State<ExerciseTab> createState() => _ExerciseTabState();
}

class _ExerciseTabState extends State<ExerciseTab> {
  late Timer _timer;

  final String _defaultPath = './assets/exercises';
  String _path = "./assets/question-mark.png";

  int _imageIndex = 1;

  @override
  void initState() {
    super.initState();

    _path = '$_defaultPath/${widget.exercise.images[0]}';

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _imageIndex = _imageIndex == 0 ? 1 : 0;
        _path = _imageIndex == 0
            ? '$_defaultPath/${widget.exercise.images[1]}'
            : '$_defaultPath/${widget.exercise.images[0]}';
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onRepCountChange(int serieIndex, String newValue) {
    if (newValue.isEmpty) newValue = "0";
    widget.exercise.workoutSets[serieIndex].reps = int.parse(newValue);
    widget.refreshWorkoutTabWidget();
  }

  void _onWeightChange(int serieIndex, String newValue) {
    if (newValue.isEmpty) newValue = "0";

    widget.exercise.workoutSets[serieIndex].weight = double.parse(newValue);
    widget.refreshWorkoutTabWidget();
  }

  void _onWeightUnitChange(WeightUnit? newWeightUnit) {
    if (newWeightUnit == null) return;

    for (WorkoutSet workoutSet in widget.exercise.workoutSets) {
      workoutSet.weight = workoutSet.weight.convertWeight(
        widget.exercise.weightUnit,
        newWeightUnit,
      );
    }

    widget.exercise.weightUnit = newWeightUnit;
    widget.refreshWorkoutTabWidget();
    setState(() {});
  }

  void _addWorkoutSet() {
    WorkoutSet newSet = widget.exercise.workoutSets.isNotEmpty
        ? widget.exercise.workoutSets.last.copy()
        : WorkoutSet(reps: 0, weight: 0, id: Uuid().v1().toString());

    widget.exercise.workoutSets = [...widget.exercise.workoutSets, newSet];

    widget.refreshWorkoutTabWidget();
    setState(() {});
  }

  void _removeSet(WorkoutSet workoutSet) {
    widget.exercise.workoutSets = widget.exercise.workoutSets
        .where((WorkoutSet s) => s.id != workoutSet.id)
        .toList();

    widget.refreshWorkoutTabWidget();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // app bar
        MyAppBar(
          title: widget.exercise.name,
          automaticallyImplyLeading: true,
          actions: [
            IconButton(
              onPressed: _addWorkoutSet,
              icon: Icon(Icons.add, size: 30),
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(_path),
              ),
              Row(
                spacing: 15,
                children: [
                  Text("Weight unit: "),
                  DropdownButton(
                    value: widget.exercise.weightUnit,
                    items: [
                      DropdownMenuItem(value: WeightUnit.kg, child: Text("kg")),
                      DropdownMenuItem(
                        value: WeightUnit.lbs,
                        child: Text("lbs"),
                      ),
                    ],
                    onChanged: _onWeightUnitChange,
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Card(
                  key: Key(index.toString()),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            spacing: 15,
                            children: [
                              Text("Reps"),
                              SizedBox(
                                width: 55,
                                child: TextFormField(
                                  key: Key(
                                    '${widget.exercise.workoutSets[index].id}_reps',
                                  ),
                                  onChanged: (value) =>
                                      _onRepCountChange(index, value),
                                  initialValue: widget
                                      .exercise
                                      .workoutSets[index]
                                      .reps
                                      .toString(),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text("Weight"),
                              SizedBox(
                                width: 65,
                                child: TextFormField(
                                  key: Key(
                                    '${widget.exercise.workoutSets[index].id}_weight',
                                  ),
                                  onChanged: (value) =>
                                      _onWeightChange(index, value),
                                  initialValue: widget
                                      .exercise
                                      .workoutSets[index]
                                      .weight
                                      .toString(),
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(widget.exercise.weightUnit.name),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              _removeSet(widget.exercise.workoutSets[index]),
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: widget.exercise.workoutSets.length,
                separatorBuilder: (context, index) => MyDivider(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
