import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/config.dart';

class AnimatedCard extends StatefulWidget {
  final Widget? child;
  final int index;
  final Color? color;
  final bool? indexDelayedAnimation;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onTap;

  const AnimatedCard({
    super.key,
    this.child,
    required this.index,
    this.color,
    this.indexDelayedAnimation = true,
    this.onLongPress,
    this.onTap,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  double _opacity = 0;
  double _scale = 0;

  @override
  void initState() {
    super.initState();

    int delay = widget.indexDelayedAnimation! ? widget.index * 100 : 100;
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) {
        setState(() {
          _scale = 1;
          _opacity = 1;
        });
      }
    });
  }

  void _onLongPressDown(LongPressDownDetails _) {
    if (widget.onLongPress == null) return;

    setState(() {
      _opacity = .2;
      _scale = .9;
    });
  }

  void _onLongPressCancel() {
    if (widget.onLongPress == null) return;

    setState(() {
      _opacity = 1;
      _scale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressDown: _onLongPressDown,
      onLongPressCancel: _onLongPressCancel,
      onLongPress: widget.onLongPress,
      onTap: widget.onTap,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: animationsDuration,
        curve: Curves.ease,
        child: AnimatedScale(
          scale: _scale,
          duration: animationsDuration,
          curve: Curves.ease,
          child: Card(color: widget.color, child: widget.child),
        ),
      ),
    );
  }
}
