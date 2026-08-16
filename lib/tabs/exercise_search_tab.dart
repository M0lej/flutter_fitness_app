import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/data/exercises.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/exercise_creator_tab.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/exercise_info_card.dart';
import 'package:gym_app/utils/exercise_search_tab/exercise_search_tab_switch_button.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:provider/provider.dart';

enum ExercisesSource { library, custom }

class ExerciseSearchTab extends StatefulWidget {
  final SettingsProvider settings;
  final DataProvider appData;

  final Function(Exercise) addExercise;
  final Iterable<String> excludedExercisesIds;
  const ExerciseSearchTab({
    super.key,
    required this.addExercise,
    required this.excludedExercisesIds,
    required this.settings,
    required this.appData,
  });

  @override
  State<ExerciseSearchTab> createState() => _ExerciseSearchTabState();
}

class _ExerciseSearchTabState extends State<ExerciseSearchTab> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  ExercisesSource _exercisesSource = ExercisesSource.library;
  List<Exercise> _exercises = [];
  List<Exercise> _exercisesSourceList = [];

  List<Exercise> _appExercises = [];

  void _changeExercisesSource(ExercisesSource newExercisesSource) {
    setState(() {
      _exercisesSource = newExercisesSource;
      _exercisesSourceList = newExercisesSource == ExercisesSource.library
          ? _appExercises
          : widget.appData.customExercises
                .where(
                  (Exercise exercise) =>
                      !widget.excludedExercisesIds.contains(exercise.id),
                )
                .toList();

      _exercises = _exercisesSourceList;
    });
  }

  @override
  void initState() {
    _loadExercises();
    super.initState();
  }

  void _loadExercises() async {
    ExerciseRepository exerciseRepository = ExerciseRepository();
    await exerciseRepository.loadExercises();

    setState(() {
      _appExercises = exerciseRepository.exercises
          // exclude exercises that are already added
          .where(
            (Exercise exercise) =>
                widget.excludedExercisesIds.contains(exercise.id) == false,
          )
          .toList();

      _exercises = _appExercises;
      _exercisesSourceList = _exercises;
    });
  }

  void _filterExercises(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        _exercises = _exercisesSourceList;
      });
      return;
    }
    List<Exercise> sortedExercises = _exercisesSourceList;

    sortedExercises.sort((Exercise a, Exercise b) {
      int scoreA = 0;
      int scoreB = 0;

      List<String> words = value.split(' ');

      for (String word in words) {
        if (a.name.toLowerCase().contains(word.toLowerCase())) {
          scoreA += 1;
        }

        if (b.name.toLowerCase().contains(word.toLowerCase())) {
          scoreB += 1;
        }
      }

      return scoreB - scoreA;
    });

    setState(() {
      _exercises = sortedExercises.sublist(0, 5);
    });
  }

  void _addExercise() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseCreatorTab(
          appData: widget.appData,
          settings: widget.settings,
          refreshCustomExercises: _refreshCustomExercises,
        ),
      ),
    );
  }

  void _refreshCustomExercises() {
    if (_exercisesSource == ExercisesSource.custom) {
      setState(() {
        _exercises = context.read<DataProvider>().customExercises;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // tab app bar
        MyAppBar(
          title: widget.settings.translations.addExercise,
          actions: [
            IconButton(
              onPressed: _addExercise,
              icon: const Icon(Icons.add, size: 30),
            ),
          ],
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
          ),
        ),

        // floating search bar and "Exercise library" / "My Exercises" switch
        SliverAppBar(
          automaticallyImplyLeading: false,
          floating: true,
          expandedHeight: 115,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: TextField(
                      onChanged: _filterExercises,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: widget.settings.translations.searchExercise,
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),

                  // "Exercise library" / "My Exercises" switch
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Row(
                        spacing: 5,
                        children: [
                          // exercises library button
                          ExerciseSearchTabSwitchButton(
                            changeExercisesSource: _changeExercisesSource,
                            exercisesSource: _exercisesSource,
                            thisExerciseSource: ExercisesSource.library,
                            labelText:
                                widget.settings.translations.exerciseLibrary,
                          ),
                          // custom exercises button
                          ExerciseSearchTabSwitchButton(
                            changeExercisesSource: _changeExercisesSource,
                            exercisesSource: _exercisesSource,
                            thisExerciseSource: ExercisesSource.custom,
                            labelText: widget.settings.translations.myExercises,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.all(15),
          sliver: SliverList.separated(
            key: _listKey,
            separatorBuilder: (context, index) => const MyDivider(),
            itemCount: _exercises.length,
            itemBuilder: (context, index) {
              Exercise exercise = _exercises[index];

              return ExerciseInfoCard(
                index: index,
                exercise: exercise,
                addExercise: widget.addExercise,
                settings: widget.settings,
                appData: widget.appData,
                refreshCustomExercises: _refreshCustomExercises,
                canBeDeleted: _exercisesSource == ExercisesSource.custom,
              );
            },
          ),
        ),
      ],
    );
  }
}
