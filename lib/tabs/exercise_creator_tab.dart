import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/category_expand_button.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/my_segmented_button.dart';
import 'package:provider/provider.dart';

class ExerciseCreatorTab extends StatefulWidget {
  final SettingsProvider settings;
  final DataProvider appData;
  const ExerciseCreatorTab({
    super.key,
    required this.settings,
    required this.appData,
  });

  @override
  State<ExerciseCreatorTab> createState() => _ExerciseCreatorTabState();
}

class _ExerciseCreatorTabState extends State<ExerciseCreatorTab> {
  String _name = "";
  final Set<String> _primaryMuscles = {};
  final Set<String> _secondaryMuscles = {};
  String _equipment = "";

  @override
  void initState() {
    super.initState();
    _equipment = widget.settings.translations.equipmentSet.last; // None
  }

  void _addExercise() {
    if (_name.isEmpty || _equipment.isEmpty) return;
    widget.appData.addExercise(
      _name,
      _equipment,
      _primaryMuscles.toList(),
      _secondaryMuscles.toList(),
    );
    Navigator.pop(context);
  }

  void _changePrimaryMuscles(String muscle, bool value) {
    if (value) {
      setState(() => _primaryMuscles.add(muscle));
    } else {
      setState(() => _primaryMuscles.remove(muscle));
    }
  }

  void _changeSecondaryMuscles(String muscle, bool value) {
    if (value) {
      setState(() => _secondaryMuscles.add(muscle));
    } else {
      setState(() => _secondaryMuscles.remove(muscle));
    }
  }

  void _changeEquipment(String equipment, bool value) {
    if (value) {
      setState(() => _equipment = equipment);
    } else {
      setState(
        () => _equipment = widget.settings.translations.equipmentSet.last,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settings, appData, child) => CustomScrollView(
        slivers: [
          MyAppBar(
            title: settings.translations.exerciseCreator,
            actions: [
              IconButton(
                icon: const Icon(Icons.check, size: 30),
                onPressed: _addExercise,
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                ),
              ),
            ],
            leading: IconButton(
              onPressed: () => closeWithoutSaving(context),
              icon: const Icon(Icons.arrow_back),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList.list(
              children: [
                // exercise name
                Text(
                  settings.translations.name,
                  style: const TextStyle(fontSize: 15),
                ),

                const MyDivider(),

                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    enableSuggestions: false,
                    onChanged: (value) => _name = value,
                    decoration: InputDecoration(
                      hintText: settings.translations.exerciseName,
                      suffixIcon: const Icon(Icons.abc),
                    ),
                  ),
                ),

                MyDivider(),

                // primary muscles selector
                CategoryExpandButton(
                  labelText: settings.translations.primaryMuscles,
                  child: Column(
                    spacing: 5,
                    children: settings.translations.musclesCategorized.entries
                        .map((entry) {
                          String muscleCategory = entry.key;
                          Set<String> muscleSet = entry.value;

                          return CategoryExpandButton(
                            labelText: muscleCategory,
                            child: MySegmentedButton(
                              segments: muscleSet,
                              initialValues: _primaryMuscles,
                              onChanged: (selectedSet, muscle, value) =>
                                  _changePrimaryMuscles(muscle, value),
                            ),
                          );
                        })
                        .toList(),
                  ),
                ),

                const MyDivider(),

                // secondary muscles selector
                CategoryExpandButton(
                  labelText: settings.translations.secondaryMuscles,
                  child: Column(
                    spacing: 5,
                    children: settings.translations.musclesCategorized.entries
                        .map((entry) {
                          final String muscleCategory = entry.key;
                          final Set<String> muscleSet = entry.value;

                          return CategoryExpandButton(
                            labelText: muscleCategory,
                            child: MySegmentedButton(
                              segments: muscleSet,
                              initialValues: _secondaryMuscles,
                              onChanged: (selectedSet, muscle, value) =>
                                  _changeSecondaryMuscles(muscle, value),
                            ),
                          );
                        })
                        .toList(),
                  ),
                ),

                const MyDivider(),

                CategoryExpandButton(
                  labelText: settings.translations.equipment,
                  child: MySegmentedButton(
                    multiSelection: false,
                    minSelection: 1,
                    segments: settings.translations.equipmentSet,
                    initialValues: {_equipment},
                    onChanged: (_, equipment, value) =>
                        _changeEquipment(equipment, value),
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
