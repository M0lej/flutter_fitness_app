import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/settings/languages/translations.dart';

enum InputType { reps, weight }

class WorkoutSetItemInput extends StatefulWidget {
  final Exercise exercise;
  final int index;
  final Translations translations;
  final InputType inputType;
  final String? initialValue;
  final num? last;
  final WeightUnit? lastWeightUnit;

  final Function(int, String) onChange;

  const WorkoutSetItemInput({
    super.key,
    required this.exercise,
    required this.index,
    required this.onChange,
    required this.translations,
    required this.inputType,
    this.initialValue,
    required this.last,
    this.lastWeightUnit,
  });

  @override
  State<WorkoutSetItemInput> createState() => _WorkoutSetItemInputState();
}

class _WorkoutSetItemInputState extends State<WorkoutSetItemInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue?.toString() ?? '';
  }

  @override
  void didUpdateWidget(covariant WorkoutSetItemInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      final newValue = widget.initialValue?.toString() ?? '';
      if (_controller.text != newValue) {
        _controller.text = newValue;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _replaceInputValueWithPreviousData() {
    setState(() {
      _controller.text = widget.last.toString();
      widget.onChange(widget.index, _controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final setId = widget.exercise.workoutSets[widget.index].id;

    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 10,
          children: [
            SizedBox(
              width: 90,
              child: TextFormField(
                controller: _controller,
                key: ValueKey('${setId}_${widget.inputType.name}'),
                onChanged: (value) => widget.onChange(widget.index, value),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              widget.inputType == InputType.reps
                  ? widget.translations.reps
                  : widget.translations.weight,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        if (widget.last != null)
          GestureDetector(
            onTap: _replaceInputValueWithPreviousData,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_drop_up,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Text(
                  '${widget.translations.last} ${widget.last} ${widget.inputType == InputType.weight ? widget.lastWeightUnit?.name ?? '' : ''}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
