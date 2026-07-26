import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final double size;
  final String path;
  const MyImage({super.key, required this.size, required this.path});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(path, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
