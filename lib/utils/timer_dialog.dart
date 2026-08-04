import 'package:flutter/material.dart';
import 'package:gym_app/data/timer_provider.dart';
import 'package:gym_app/extensions/int_extensions.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:provider/provider.dart';

class TimerDialog extends StatefulWidget {
  const TimerDialog({super.key});

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

  void _startTimer() {
    Duration duration = Duration(
      minutes: _time.toInt(),
      seconds: ((_time - _time.toInt()) * 60).toInt(),
    );

    context.read<TimerProvider>().start(
      duration,
      context.read<SettingsProvider>().language,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "${_time.toInt().toTwoDigitString()}:${(((_time - _time.toInt()) * 60).toInt().toTwoDigitString())}",
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: _addTime, icon: const Icon(Icons.add)),
          TextButton.icon(
            onPressed: () {
              _startTimer();
              Navigator.pop(context);
            },
            label: Text("Start"),
            icon: const Icon(Icons.play_arrow),
          ),
          IconButton(onPressed: _subTime, icon: const Icon(Icons.remove)),
        ],
      ),
    );
  }
}
