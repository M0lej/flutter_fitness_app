import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/serie.dart';
import 'package:gym_app/utils/my_divider.dart';

class ExerciseTab extends StatelessWidget {
  final Exercise exercise;
  const ExerciseTab({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: AutoSizeText(
            exercise.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(15),
          sliver: SliverList.list(
            children: [
              // FIXME:Make reorderablelistview work
              
              ReorderableListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                  key: Key(index.toString()),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      spacing: 15,
                      children: [
                        Text("Reps"),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            initialValue: exercise.series[index].reps
                                .toString(),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Text("Weight"),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            initialValue: exercise.series[index].weight
                                .toString(),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: exercise.series.length,
                onReorderItem: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  Serie serie = exercise.series.removeAt(oldIndex);
                  exercise.series.insert(newIndex, serie);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
