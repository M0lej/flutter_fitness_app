import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gym_app/utils/countdown_dialog.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/timer_dialog.dart';

class WorkoutTimer extends StatefulWidget {
  const WorkoutTimer({super.key});

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();
  Duration _duration = Duration.zero;

  void _startTimer(double time) {
    _stopwatch.reset();
    _stopwatch.start();

    setState(() {
      _duration = Duration(
        minutes: time.toInt(),
        seconds: ((time - time.toInt()) * 60).toInt(),
      );

      _timer = Timer(_duration, () async {
        _stopwatch.reset();

        showDialog(
          context: context,
          builder: (context) => MyAlertDialog(
            title: "Time is up!",
            buttons: [
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                label: Text("Ok"),
              ),
            ],
          ),
        );
      });
    });
  }

  void _showTimerPopup() {
    if (_timer?.isActive ?? false) {
      showDialog(
        context: context,
        builder: (context) => CountdownDialog(
          elapsed: _stopwatch.elapsed,
          duration: _duration,
          timer: _timer!,
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) => TimerDialog(startTimer: _startTimer),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showTimerPopup,
      child: Row(
        spacing: 15,
        children: [Icon(Icons.timer_outlined), Text("Timer")],
      ),
    );
  }
}
