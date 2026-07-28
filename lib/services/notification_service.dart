import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await notifications.initialize(settings: settings);
  }
}
