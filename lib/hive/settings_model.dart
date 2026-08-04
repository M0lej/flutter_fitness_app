import 'package:gym_app/hive/language.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 9)
class SettingsModel {
  @HiveField(0)
  Language language;

  @HiveField(1)
  WeightUnit weightUnit;

  @HiveField(2)
  int weekWorkoutsGoal;

  factory SettingsModel.getDefault() => SettingsModel(
    language: Language.en,
    weightUnit: WeightUnit.kg,
    weekWorkoutsGoal: 4,
  );

  SettingsModel({
    required this.language,
    required this.weightUnit,
    required this.weekWorkoutsGoal,
  });
}
