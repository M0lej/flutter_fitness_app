import 'package:flutter/material.dart';
import 'package:gym_app/themes/app_theme.dart';

class ToggleTextButton extends StatefulWidget {
  final bool defaultSelected;
  final String labelText;
  final Function(bool)? onChange;
  final bool canBeToggledOn;

  const ToggleTextButton({
    super.key,
    this.defaultSelected = false,
    required this.labelText,
    required this.onChange,
    this.canBeToggledOn = true,
  });

  @override
  State<ToggleTextButton> createState() => _ToggleTextButtonState();
}

class _ToggleTextButtonState extends State<ToggleTextButton> {
  bool _selected = false;

  @override
  void initState() {
    super.initState();
    _selected = widget.defaultSelected;
  }

  void _changeSelection() {
    if (!_selected == true && !widget.canBeToggledOn) return;

    setState(() {
      _selected = !_selected;
    });

    if (widget.onChange != null) {
      widget.onChange!(_selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _changeSelection(),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          _selected ? AppTheme.red : Colors.transparent,
        ),
        side: WidgetStatePropertyAll(
          BorderSide(
            color: _selected ? Colors.transparent : AppTheme.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Text(
        widget.labelText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
