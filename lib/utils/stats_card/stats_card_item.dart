import 'package:flutter/material.dart';

class StatsCardItem extends StatelessWidget {
  final String value;
  final String labelText;
  final Widget icon;
  const StatsCardItem({
    super.key,
    required this.value,
    required this.labelText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        icon,
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          labelText,
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
