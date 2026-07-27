import 'package:flutter/material.dart';
import 'package:gym_app/extensions/int_extensions.dart';

class TimerDialog extends StatefulWidget {
  final Function(double) startTimer;
  const TimerDialog({super.key, required this.startTimer});

  @override
  State<TimerDialog> createState() => _TimerDialogState();
}

class _TimerDialogState extends State<TimerDialog> {
  double _time = 2.0;

  void _addTime() {
    setState(() {
      _time += .5;
    });
  }

  void _subTime() {
    if (_time - .5 < 0) return;

    setState(() {
      _time -= .5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "${_time.toInt().toTwoDigitString()}:${(((_time - _time.toInt()) * 60).toInt().toTwoDigitString())}",
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: _addTime, icon: Icon(Icons.add)),
          TextButton.icon(
            onPressed: () {
              widget.startTimer(_time);
              Navigator.pop(context);
            },
            label: Text("Start"),
            icon: Icon(Icons.play_arrow),
          ),
          IconButton(onPressed: _subTime, icon: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
