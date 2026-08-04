import 'package:flutter/material.dart';
import 'package:gym_app/themes/app_theme.dart';

class ToggleTextButton extends StatelessWidget {
  final String labelText;
  final String value;
  final Function(String, bool) onChange;
  final bool selected;

  const ToggleTextButton({
    super.key,
    this.selected = false,
    required this.labelText,
    required this.onChange,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onChange(value, !selected),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          selected ? AppTheme.red : Colors.transparent,
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: selected ? Colors.transparent : AppTheme.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Text(labelText, style: const TextStyle(color: Colors.white)),
    );
  }
}
