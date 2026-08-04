import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/data/timer_provider.dart';
import 'package:gym_app/hive/data_model.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/exercise_stats.dart';
import 'package:gym_app/hive/language.dart';
import 'package:gym_app/hive/month_stats.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/settings_model.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/services/notification_service.dart';
import 'package:gym_app/tabs/app_tabs_controller.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/my_alert_dialog.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init notification service
  await NotificationService.instance.initialize();
  await NotificationService.instance.notifications
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();

  // init hive
  await Hive.initFlutter();

  // register all adapters
  Hive.registerAdapter(DataModelAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutSetAdapter());
  Hive.registerAdapter(PlanAdapter());
  Hive.registerAdapter(WorkoutLogAdapter());
  Hive.registerAdapter(WeightUnitAdapter());
  Hive.registerAdapter(MonthStatsAdapter());
  Hive.registerAdapter(ExerciseStatsAdapter());
  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(LanguageAdapter());

  // await Hive.deleteBoxFromDisk('data');
  // await Hive.deleteBoxFromDisk('settings');

  await Hive.openBox<DataModel>('data');
  await Hive.openBox<SettingsModel>('settings');

  runApp(
    // init providers with default data
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
        ChangeNotifierProvider(create: (_) => TimerProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: appNavigatorKey,
      theme: AppTheme().dark,
      home: AppTabsController(),
    );
  }
}
