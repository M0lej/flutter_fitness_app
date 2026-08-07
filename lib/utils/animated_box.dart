import 'package:flutter/material.dart';
import 'package:gym_app/config.dart';

class AnimatedBox extends StatefulWidget {
  final Widget? child;
  final int index;
  const AnimatedBox({super.key, this.child, required this.index});

  @override
  State<AnimatedBox> createState() => _AnimatedBoxboxState();
}

class _AnimatedBoxboxState extends State<AnimatedBox> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      setState(() => _animate = true);
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
        child: widget.child,
      ),
    );
  }
}
