import 'package:flutter/material.dart';
import 'package:gym_app/config.dart';

class AnimatedCard extends StatefulWidget {
  final Widget? child;
  final int index;
  final Color? color;
  final bool? indexDelayedAnimation;
  const AnimatedCard({
    super.key,
    this.child,
    required this.index,
    this.color,
    this.indexDelayedAnimation = true,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();

    int delay = widget.indexDelayedAnimation! ? widget.index * 100 : 100;
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) {
        setState(() => _animate = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _animate ? 1 : 0,
      duration: animationsDuration,
      curve: Curves.ease,
      child: AnimatedScale(
        scale: _animate ? 1 : 0,
        duration: animationsDuration,
        curve: Curves.ease,
        child: Card(color: widget.color, child: widget.child),
      ),
    );
  }
}
