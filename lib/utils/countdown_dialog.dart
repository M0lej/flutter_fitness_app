import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gym_app/extensions/int_extensions.dart';

class CountdownDialog extends StatefulWidget {
  final Duration elapsed;
  final Duration duration;
  final Timer timer;

  const CountdownDialog({
    super.key,
    required this.elapsed,
    required this.duration,
    required this.timer,
  });

  @override
  State<CountdownDialog> createState() => _CountdownDialogState();
}

class _CountdownDialogState extends State<CountdownDialog> {
  late Timer _timer;
  late Duration _elapsed;
  late DateTime _startedAt;

  @override
  void initState() {
    _elapsed = widget.elapsed;
    _startedAt = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsed = widget.elapsed + DateTime.now().difference(_startedAt);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final remainingTime = widget.duration > _elapsed
        ? widget.duration - _elapsed
        : Duration.zero;

    if (remainingTime == Duration.zero) {
      Navigator.pop(context);
    }

    return AlertDialog(
      title: Text(
        "${remainingTime.inMinutes.toInt().toTwoDigitString()}:${(remainingTime.inSeconds % 60).toTwoDigitString()}",
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () {
              widget.timer.cancel();
              Navigator.pop(context);
            },
            label: Text("Stop"),
          ),
        ],
      ),
    );
  }
}
