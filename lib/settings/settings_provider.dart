import 'package:flutter/material.dart';
import 'package:gym_app/hive/language.dart';
import 'package:gym_app/hive/settings_model.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/settings/languages/english_translations.dart';
import 'package:gym_app/settings/languages/polish_translations.dart';
import 'package:gym_app/settings/languages/translations.dart';
import 'package:hive_flutter/adapters.dart';

class SettingsProvider extends ChangeNotifier {
  final Box<SettingsModel> _box = Hive.box('settings');

  late SettingsModel _settings;

  Language get language => _settings.language;

  WeightUnit get weightUnit => _settings.weightUnit;

  int get weekWorkoutsGoal => _settings.weekWorkoutsGoal;

  late Translations translations;

  SettingsProvider() {
    _settings = _box.get('settings') ?? SettingsModel.getDefault();
    translations = _getTranslations(language);
  }

  Future<void> changeLanguage({required Language language}) async {
    _settings.language = language;
    translations = _getTranslations(language);

    await _save();
  }

  Future<void> changeWeightUnit({required WeightUnit weightUnit}) async {
    _settings.weightUnit = weightUnit;

    await _save();
  }

  Future<void> setWeekWorkoutsGoal(int goal) async {
    _settings.weekWorkoutsGoal = goal;

    await _save();
  }

  Future<void> _save() async {
    await _box.put('settings', _settings);

    notifyListeners();
  }

  Translations _getTranslations(Language language) => switch (language) {
    Language.pl => PolishTranslations(),
    Language.en => EnglishTranslations(),
  };

  String getLanguageNameString(Language language) {
    switch (language) {
      case Language.pl:
        return "Polski";
      case Language.en:
        return "English";
    }
  }
}
