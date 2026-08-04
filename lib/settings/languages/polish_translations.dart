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
  String get home => "Strona główna";

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
  String Function(int) get exercises =>
      (int exercisesNum) => switch (exercisesNum) {
        1 => "ćwiczenie",
        2 || 3 || 4 => "ćwiczenia",
        _ => "ćwiczeń",
      };

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
  String get edit => "Edytuj";

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

  @override
  String get planCreator => "Kreator planów";

  @override
  String get icon => "Ikona";

  @override
  String get name => "Nazwa";

  @override
  String get enterANameForYourWorkoutPlan => "Podaj nazwe dla twojego planu";

  @override
  String get exercises2 => "Ćwiczenia";

  @override
  String get addExercise => "Dodaj ćwiczenie";

  @override
  String get exerciseLibrary => "Biblioteka ćwiczeń";

  @override
  String get myExercises => "Moje ćwiczenia";

  @override
  String get searchExercise => "Szukaj ćwiczenia...";

  @override
  String get exerciseCreator => "Kreator ćwiczeń";

  @override
  String get exerciseName => "Nazwa ćwiczenia";

  @override
  String get primaryMuscles => "Główne mięśnie";

  @override
  String get secondaryMuscles => "Mięśnie pomocnicze";

  @override
  String get equipment => "Sprzęt";

  @override
  Map<String, Set<String>> get musclesCategorized => {
    // Klatka piersiowa
    'Klatka piersiowa': {
      'Klatka piersiowa',
      'Górna część klatki piersiowej',
      'Dolna część klatki piersiowej',
    },

    // Plecy
    'Plecy': {
      'Mięśnie najszersze grzbietu',
      'Górna część pleców',
      'Środkowa część pleców',
      'Dolna część pleców',
      'Mięśnie czworoboczne',
    },

    // Barki
    'Barki': {'Przedni akton', 'Boczny akton', 'Tylny akton'},

    // Ramiona
    'Ramiona': {
      'Biceps',
      'Triceps',
      'Przedramiona',
      'Mięsień ramienny',
      'Mięsień ramienno-promieniowy',
    },

    // Core
    'Mięśnie brzucha': {
      'Mięśnie proste brzucha',
      'Mięśnie skośne brzucha',
      'Mięsień poprzeczny brzucha',
      'Prostowniki grzbietu',
    },

    // Nogi
    'Nogi': {
      'Mięśnie czworogłowe uda',
      'Mięśnie dwugłowe uda',
      'Pośladki',
      'Zginacze bioder',
      'Przywodziciele',
      'Odwodziciele',
      'Łydki',
      'Mięsień piszczelowy przedni',
    },

    // Szyja
    'Szyja': {'Szyja'},
  };

  @override
  Set<String> get equipmentSet => {
    'Sztanga',
    'Hantle',
    'Kettlebell',

    'Wyciąg',
    'Maszyna',
    'Suwnica Smitha',

    'Ławka',
    'Ławka skośna dodatnia',
    'Ławka skośna ujemna',

    'Drążek',
    'Poręcze',

    'Gryf łamany',
    'Trap Bar',

    'Guma oporowa',
    'Taśmy TRX',

    'Piłka lekarska',
    'Piłka gimnastyczna',

    'Sanki treningowe',
    'Landmine',

    'Masa własnego ciała',

    'Inne',
  };

  @override
  String get progressOverview => "POSTĘPY";

  @override
  String get workouts => "Liczba treningów";

  @override
  String get vsLastMonth => "vs poprzedni miesiąc";

  @override
  String get language => "JĘZYK";

  @override
  String get timeIsUp => "Czas upłynął!";

  @override
  String get save => "Zapisz";

  @override
  String get weeklyTrainingGoal => "TYGODNIOWY CEL TRENINGOWY";
  @override
  String get pleaseEnterACorrectNumber => "Prosze wprowadzić prawidłową liczbe";
  @override
  String get weeklyGoalNumberMustBe =>
      "Prosze wprowadzić liczbę znajdującą się w przedziale od 0 do 7";
}
