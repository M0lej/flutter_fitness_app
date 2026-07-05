import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyIcon extends StatelessWidget {
  final double size;
  final Widget icon;
  const MyIcon({super.key, required this.size, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              color: const Color.fromARGB(255, 52, 48, 62),
            ),
          ],
        ),
        child: FittedBox(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
