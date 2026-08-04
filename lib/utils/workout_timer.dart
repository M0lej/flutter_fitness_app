import 'package:flutter/material.dart';
import 'package:gym_app/data/timer_provider.dart';
import 'package:gym_app/utils/countdown_dialog.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:gym_app/utils/timer_dialog.dart';
import 'package:provider/provider.dart';

class WorkoutTimer extends StatelessWidget {
  const WorkoutTimer({super.key});

  @override
  Widget build(BuildContext context) {
    void showTimerPopup() {
      if (context.read<TimerProvider>().isActive()) {
        showAppDialog<void>(builder: (dialogContext) => CountdownDialog());
        return;
      }
      showAppDialog<void>(builder: (dialogContext) => TimerDialog());
    }

    return GestureDetector(
      onTap: showTimerPopup,
      child: const Row(
        spacing: 15,
        children: [
          Icon(Icons.timer_outlined),
          Text("Timer", style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
