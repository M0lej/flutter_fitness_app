import 'package:flutter/material.dart';
import 'package:gym_app/utils/toggle_text_button.dart';

class MySegmentedButton extends StatefulWidget {
  final Set<String> segments;
  final Function(Set<String>, String, bool) onChanged;
  final Set<String> initialValues;
  final bool multiSelection;
  final int minSelection;

  const MySegmentedButton({
    super.key,
    required this.segments,
    required this.onChanged,
    this.initialValues = const {},
    this.multiSelection = true,
    this.minSelection = 0,
  });

  @override
  State<MySegmentedButton> createState() => _MySegmentedButtonState();
}

class _MySegmentedButtonState extends State<MySegmentedButton> {
  late Set<String> selectedValues;

  @override
  void initState() {
    super.initState();
    selectedValues = Set<String>.from(widget.initialValues);
  }

  void _changeSelection(String segment, bool value) {
    if (widget.minSelection == 1) {
      if (value) {
        setState(() {
          selectedValues = {segment};
        });
      }
    } else if (value &&
        (widget.multiSelection == true ||
            (widget.multiSelection == false && selectedValues.isEmpty))) {
      setState(() {
        selectedValues.add(segment);
      });
    } else if (selectedValues.length - 1 >= widget.minSelection) {
      setState(() {
        selectedValues.remove(segment);
      });
    }
    widget.onChanged(selectedValues, segment, value);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 15,
      children: widget.segments
          .map(
            (String segment) => ToggleTextButton(
              labelText: segment,
              value: segment,
              onChange: _changeSelection,
              selected: selectedValues.contains(segment),
            ),
          )
          .toList(),
    );
  }
}
