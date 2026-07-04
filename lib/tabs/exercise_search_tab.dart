import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/data/exercises.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/my_divider.dart';

enum ExercisesSource { library, custom }

class ExerciseSearchTab extends StatefulWidget {
  final Function(Exercise) addExercise;
  final Iterable<String> excludedExercisesIds;
  const ExerciseSearchTab({
    super.key,
    required this.addExercise,
    required this.excludedExercisesIds,
  });

  @override
  State<ExerciseSearchTab> createState() => _ExerciseSearchTabState();
}

class _ExerciseSearchTabState extends State<ExerciseSearchTab> {
  ExercisesSource _exercisesSource = ExercisesSource.library;
  List<Exercise> _exercises = [];
  List<Exercise> _filteredExercises = [];

  void _changeExercisesSource(ExercisesSource newExercisesSource) {
    setState(() {
      _exercisesSource = newExercisesSource;
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
      _exercises = exerciseRepository.exercises
          // exclude exercises that are already added
          .where(
            (Exercise exercise) =>
                widget.excludedExercisesIds.contains(exercise.id) == false,
          )
          .toList();
      _filteredExercises = _exercises;
    });
  }

  void _filterExercises(String value) {
    if (value.trim().isEmpty) {
      setState(() {
        _filteredExercises = _exercises;
      });
      return;
    }
    List<Exercise> sortedExercises = _exercises;

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
      _filteredExercises = sortedExercises.sublist(0, 5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // tab app bar
        SliverAppBar(title: Text("Add Exercise"), toolbarHeight: 50),

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
                  // search bar
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: TextField(
                      onChanged: _filterExercises,
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "Search exercises...",
                        prefixIcon: Icon(Icons.search),
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
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () => _changeExercisesSource(
                                ExercisesSource.library,
                              ),
                              label: Text(
                                "Exercise Library",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              icon: Icon(Icons.book),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  _exercisesSource == ExercisesSource.library
                                      ? AppTheme.red
                                      : Theme.of(context).cardTheme.color,
                                ),
                              ),
                            ),
                          ),

                          // custom exercises button
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () => _changeExercisesSource(
                                ExercisesSource.custom,
                              ),
                              label: Text(
                                "My exercises",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              icon: Icon(Icons.person),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  _exercisesSource == ExercisesSource.custom
                                      ? AppTheme.red
                                      : Theme.of(context).cardTheme.color,
                                ),
                              ),
                            ),
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
            itemCount: _filteredExercises.length,
            itemBuilder: (context, index) {
              Exercise exercise = _filteredExercises[index];

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            exercise.name,
                            maxFontSize: 15,
                            style: TextStyle(fontSize: 15),
                          ),

                          Text(
                            exercise.primaryMuscles?.join(", ") ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => widget.addExercise(exercise),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => MyDivider(),
          ),
        ),
      ],
    );
  }
}
