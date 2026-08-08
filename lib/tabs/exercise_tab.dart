import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/extensions/weight_extensions.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/workout_set_item.dart';
import 'package:uuid/uuid.dart';

class ExerciseTab extends StatefulWidget {
  final SettingsProvider settings;
  final DataProvider appData;
  final bool viewMode;

  final Exercise exercise;
  final Function refreshWorkoutTabWidget;
  const ExerciseTab({
    super.key,
    required this.exercise,
    required this.refreshWorkoutTabWidget,
    required this.appData,
    required this.settings,
    this.viewMode = false,
  });

  @override
  State<ExerciseTab> createState() => _ExerciseTabState();
}

class _ExerciseTabState extends State<ExerciseTab> {
  Timer? _timer;

  final String _defaultPath = './assets/exercises';
  String _path = "./assets/question-mark.png";

  int _imageIndex = 1;

  late List<TextEditingController> _weightControllers;

  @override
  void initState() {
    super.initState();

    _weightControllers = List.generate(
      widget.exercise.workoutSets.length,
      (index) => TextEditingController(
        text: widget.exercise.workoutSets[index].weight.toString(),
      ),
    );

    if (widget.exercise.images.isNotEmpty) {
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
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _weightControllers) {
      controller.dispose();
    }
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

    for (int index = 0; index < widget.exercise.workoutSets.length; index++) {
      final workoutSet = widget.exercise.workoutSets[index];
      workoutSet.weight = workoutSet.weight.convertWeight(
        widget.exercise.weightUnit,
        newWeightUnit,
      );
      _weightControllers[index].text = workoutSet.weight.toString();
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
    _weightControllers.add(
      TextEditingController(text: newSet.weight.toString()),
    );

    widget.refreshWorkoutTabWidget();
    setState(() {});
  }

  void _removeSet(WorkoutSet workoutSet) {
    final setIndex = widget.exercise.workoutSets.indexWhere(
      (WorkoutSet s) => s.id == workoutSet.id,
    );

    if (setIndex >= 0) {
      _weightControllers[setIndex].dispose();
      _weightControllers.removeAt(setIndex);
    }

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
              icon: const Icon(Icons.add, size: 30),
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
              if (widget.exercise.images.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(_path),
                ),

              MyDivider(),

              if (widget.exercise.instructions != null)
                Text(
                  widget.settings.translations.instructions,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

              if (widget.exercise.instructions != null)
                AutoSizeText(
                  widget.exercise.instructions?.join('\n') ?? '',
                  style: const TextStyle(fontSize: 13),
                ),

              Row(
                spacing: 15,
                children: [
                  Text(widget.settings.translations.weightUnit),
                  DropdownButton(
                    value: widget.exercise.weightUnit,
                    items: [
                      DropdownMenuItem(
                        value: WeightUnit.kg,
                        child: const Text("kg"),
                      ),
                      DropdownMenuItem(
                        value: WeightUnit.lbs,
                        child: const Text("lbs"),
                      ),
                    ],
                    onChanged: _onWeightUnitChange,
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => WorkoutSetItem(
                  exercise: widget.exercise,
                  index: index,
                  onRepCountChange: _onRepCountChange,
                  onWeightChange: _onWeightChange,
                  settings: widget.settings,
                  weightController: _weightControllers[index],
                  removeSet: _removeSet,
                ),
                itemCount: widget.exercise.workoutSets.length,
                separatorBuilder: (context, index) => const MyDivider(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
