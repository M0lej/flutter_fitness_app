import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gym_app/extensions/int_extensions.dart';
import 'package:gym_app/hive/workout_log.dart';

class WorkoutClock extends StatefulWidget {
  final WorkoutLog activeWorkout;
  const WorkoutClock({super.key, required this.activeWorkout});

  @override
  State<WorkoutClock> createState() => _WorkoutClockState();
}

class _WorkoutClockState extends State<WorkoutClock> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(minutes: 1), (_) => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getTimeDiff(DateTime start, DateTime end) {
    Duration dateTimeDiff = end.difference(start);

    return "${dateTimeDiff.inHours.toTwoDigitString()}:${(dateTimeDiff.inMinutes % 60).toTwoDigitString()}";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 15,
      children: [
        const Icon(Icons.access_time),
        Text(
          _getTimeDiff(widget.activeWorkout.start, DateTime.now()),
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
