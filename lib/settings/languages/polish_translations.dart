import 'package:gym_app/extensions/string_extensions.dart';
import 'package:gym_app/settings/languages/translations.dart';

class PolishTranslations extends Translations {
  @override
  String get goodMorning => "Dzień dobry";

  @override
  String get goodAfternoon => "Dzień dobry";

  @override
  String get goodEvening => "Dobry wieczór";

  @override
  String get motivationText => "Gotowy osiągnąć swoje cele?";

  @override
  String get home => "Strona głowna";

  @override
  String get plans => "Plany";

  @override
  String get stats => "Statystyki";

  @override
  String get settings => "Ustawienia";

  @override
  List<String> get weekDayNamesShort => <String>[
    "PON",
    "WT",
    "ŚR",
    "CZW",
    "PT",
    "SOB",
    "NIEDZ",
  ];

  @override
  List<String> get monthNames => <String>[
    "stycznia",
    "luty",
    "marca",
    "kwietnia",
    "maja",
    "czerwca",
    "lipca",
    "sierpnia",
    "września",
    "października",
    "listopada",
    "grudnia",
  ];

  @override
  String Function(DateTime) get formattedDate =>
      (DateTime date) =>
          '${weekDayNamesShort[date.weekday - 1].firstToUpperRestToLower()}. ${date.day} ${monthNames[date.month - 1]}';

  @override
  String Function(int, int) get workoutProgress =>
      (int progress, int goal) => 'Ukończono $progress z $goal treningów';

  @override
  String get exercises => "ćwiczeń";

  @override
  String get startWorkout => "Rozpocznij trening";

  @override
  String get selectWorkout => "Wybierz trening";

  @override
  String get allPlansHaveBeenCompleted =>
      "Wszystkie treningi zostały ukończone! 🔥";

  @override
  String get continueMessage =>
      "Jeśli jednak nie jesteś zadowolony, możesz kontynuować...";

  // labels
  @override
  String get nextWorkout => "NASTĘPNY TRENING";

  @override
  String get thisWeek => "TEN TYDZIEŃ";

  @override
  String get recentWorkouts => "OSTATNIE TRENINGI";

  @override
  String get yourPlans => "TWOJE PLANY";

  @override
  String get activeWorkout => "AKTYWNY TRENING";

  @override
  String get onlyOneSessionTitle => "Możesz mieć aktywny tylko jeden trening";

  @override
  String Function(String) get onlyOneSessionDesc =>
      (String planName) => 'Ukończ $planName zanim rozpoczniesz następny';

  @override
  String get created => "Utworzono";

  @override
  String get areYouSureYouWantToDelete =>
      "Czy na pewno chcesz usunąć plan treningowy o nazwie";

  @override
  String get thisActionCannotBeUndone => "Tej czynności nie da się odwrócić!";

  @override
  String get delete => "Usuń";

  @override
  String get cancel => "Anuluj";

  @override
  String get weightUnit => "Jednostka wagi";

  @override
  String get reps => "Powtórzenia";

  @override
  String get weight => "Ciężar";

  @override
  String get areSureYouWantToExitWithoutSaving =>
      "Czy na pewno chcesz wyjść bez zapisywania?";

  @override
  String get areYouSureWantToUpdateThisWorkout =>
      "Czy na pewno chcesz zaktualizować trening?";

  @override
  String get areYouSureYouWantToEnd => "Czy na pewno chcesz zakończyć trening";

  @override
  String get doYouWantToSaveChangesToYourPlan =>
      "Czy chcesz zaktualizować zmiany w twoim planie treningowym?";

  @override
  String get yes => "Tak";

  @override
  String get no => "Nie";
}
