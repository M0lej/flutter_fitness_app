import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/my_icon.dart';
import 'package:gym_app/tabs/plan_creator_tab.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final Function(Exercise) removeExercise;
  final Function(Exercise, bool) changeOrder;

  final bool? isFirst;
  final bool? isLast;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.removeExercise,
    this.isFirst = false,
    this.isLast = false,
    required this.changeOrder,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 15,
              children: [
                MyIcon(size: 40, faIcon: FaIcon(FontAwesomeIcons.dumbbell)),
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
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (!isFirst!)
                  IconButton(
                    onPressed: () => changeOrder(exercise, true),
                    icon: Icon(Icons.keyboard_arrow_up),
                  ),
                if (!isLast!)
                  IconButton(
                    onPressed: () => changeOrder(exercise, false),
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
              ],
            ),
            IconButton(
              onPressed: () => removeExercise(exercise),
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ],
    );
  }
}
