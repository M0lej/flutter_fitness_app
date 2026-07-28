import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gym_app/services/notification_service.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;

  Duration remaining = Duration.zero;
  DateTime? _endTime;

  void start(Duration duration) {
    _endTime = DateTime.now().add(duration);
    remaining = duration;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _update();
    });
  }

  void cancel() {
    if (_timer == null) return;

    _timer!.cancel();
    remaining = Duration.zero;
  }

  bool isActive() => remaining > Duration.zero;

  void _update() async {
    if (_endTime == null) return;

    remaining = _endTime!.difference(DateTime.now());

    if (remaining <= Duration.zero) {
      remaining = Duration.zero;
      _timer?.cancel();

      showAppDialog<void>(
        builder: (dialogContext) => MyAlertDialog(
          title: "Time is up!",
          buttons: [
            TextButton.icon(
              onPressed: () => Navigator.pop(dialogContext),
              label: const Text("Ok"),
            ),
          ],
        ),
      );

      await NotificationService.instance.notifications.show(
        id: 0,
        title: "Timer",
        body: "Time is up!",
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'timer_channel',
            'Timer',
            channelDescription: 'Powiadomienia timera',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
