import 'dart:ui';

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int value;
  final int maxValue;
  const ProgressBar({super.key, required this.value, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: FractionallySizedBox(
        widthFactor: clampDouble(value / (maxValue == 0 ? 1 : maxValue), 0, 1),
        alignment: Alignment.centerLeft,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
