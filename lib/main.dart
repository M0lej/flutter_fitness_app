import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/data_model.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/hive/workout_set.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/hive/workout_log.dart';
import 'package:gym_app/tabs/app_tabs_controller.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init hive
  await Hive.initFlutter();

  // register all adapters
  Hive.registerAdapter(DataModelAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutSetAdapter());
  Hive.registerAdapter(PlanAdapter());
  Hive.registerAdapter(WorkoutLogAdapter());
  Hive.registerAdapter(WeightUnitAdapter());

  // await Hive.deleteBoxFromDisk('data');
  await Hive.openBox<DataModel>('data');

  runApp(
    // init providers with default data
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(
            language: Language.pl,
            weightUnit: WeightUnit.kg,
          ),
        ),
        ChangeNotifierProvider(create: (_) => DataProvider()),
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
      theme: AppTheme().dark,
      home: AppTabsController(),
    );
  }
}
