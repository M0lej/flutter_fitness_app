import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;

  const CustomCard({
    super.key,
    this.title,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? EdgeInsetsGeometry.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            // dont display the title if title string is empty
            if (title != null)
              Text(title!.toUpperCase(), style: TextStyle(fontSize: 12)),
            ...children,
          ],
        ),
      ),
    );
  }
}
