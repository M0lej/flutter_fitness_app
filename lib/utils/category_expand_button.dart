import 'package:flutter/material.dart';

class CategoryExpandButton extends StatefulWidget {
  final String? labelText;
  final Widget? label;
  final Widget child;

  const CategoryExpandButton({
    super.key,
    this.labelText,
    this.label,
    required this.child,
  });

  @override
  State<CategoryExpandButton> createState() => _CategoryExpandButtonState();
}

class _CategoryExpandButtonState extends State<CategoryExpandButton> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Row(
                children: [
                  widget.label ??
                      Text(
                        widget.labelText ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                  Icon(
                    _expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (_expanded)
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: widget.child,
          ),
      ],
    );
  }
}
