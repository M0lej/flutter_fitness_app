import 'package:flutter/material.dart';
import 'package:gym_app/utils/toggle_text_button.dart';

class MySegmentedButton extends StatefulWidget {
  final Set<String> segments;
  final Function(Set<String>, String, bool) onChanged;
  final Set<String> initialValues;
  final bool multiSelection;

  const MySegmentedButton({
    super.key,
    required this.segments,
    required this.onChanged,
    this.initialValues = const {},
    this.multiSelection = true,
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

  void _onSelectChanged(String segment, bool value) {
    if (value) {
      setState(() {
        selectedValues.add(segment);
      });
    } else {
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
              onChange: (value) => _onSelectChanged(segment, value),
              defaultSelected: widget.initialValues.contains(segment),
              canBeToggledOn:
                  widget.multiSelection == true ||
                  (widget.multiSelection == false && selectedValues.isEmpty),
            ),
          )
          .toList(),
    );
  }
}
