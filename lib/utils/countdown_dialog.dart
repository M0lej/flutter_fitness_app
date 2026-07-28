import 'package:flutter/material.dart';
import 'package:gym_app/data/timer_provider.dart';
import 'package:gym_app/extensions/int_extensions.dart';
import 'package:provider/provider.dart';

class CountdownDialog extends StatelessWidget {
  const CountdownDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerProvider>(
      builder: (context, timerProviderValues, child) => AlertDialog(
        title: Text(
          "${timerProviderValues.remaining.inMinutes.toInt().toTwoDigitString()}:${(timerProviderValues.remaining.inSeconds % 60).toTwoDigitString()}",
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                timerProviderValues.cancel();
                Navigator.pop(context);
              },
              label: Text("Stop"),
            ),
          ],
        ),
      ),
    );
  }
}
