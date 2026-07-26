import 'package:flutter/material.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/settings/languages/english_translations.dart';
import 'package:gym_app/settings/languages/polish_translations.dart';
import 'package:gym_app/settings/languages/translations.dart';

enum Language { pl, en }


class SettingsProvider extends ChangeNotifier {
  Language language;
  late Translations translations;
  WeightUnit weightUnit;

  SettingsProvider({required this.language, required this.weightUnit}) {
    translations = _getTranslations(language);
  }

  void changeLanguage({required Language language}) async {
    this.language = language;
    translations = _getTranslations(language);

    notifyListeners();
  }

  Translations _getTranslations(Language language) => switch (language) {
    Language.pl => PolishTranslations(),
    Language.en => EnglishTranslations(),
  };
}
