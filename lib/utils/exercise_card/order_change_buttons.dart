import 'package:flutter/material.dart';
import 'package:gym_app/hive/exercise.dart';

class OrderChangeButtons extends StatelessWidget {
  final bool? isFirst;
  final bool? isLast;
  final Function(Exercise, bool) changeOrder;
  final Exercise exercise;

  const OrderChangeButtons({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    required this.changeOrder,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: !isFirst! ? () => changeOrder(exercise, true) : null,
          icon: const Icon(Icons.keyboard_arrow_up),
          disabledColor: Colors.transparent,
        ),
        IconButton(
          onPressed: !isLast! ? () => changeOrder(exercise, false) : null,
          icon: const Icon(Icons.keyboard_arrow_down),
          disabledColor: Colors.transparent,
        ),
      ],
    );
  }
}
