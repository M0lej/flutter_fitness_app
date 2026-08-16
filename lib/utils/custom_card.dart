import 'package:flutter/material.dart';
import 'package:gym_app/utils/animated_card.dart';

class CustomCard extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final int index;
  final GestureLongPressCallback? onLongPress;

  const CustomCard({
    super.key,
    this.title,
    required this.children,
    this.padding,
    this.color,
    this.onLongPress,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      index: index,
      color: color,
      onLongPress: onLongPress,
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
