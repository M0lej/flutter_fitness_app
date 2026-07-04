import 'package:gym_app/extensions/string_extensions.dart';
import 'package:gym_app/settings/languages/translations.dart';

class EnglishTranslations extends Translations {
  @override
  String get goodMorning => "Good morning";

  @override
  String get goodAfternoon => "Good afternoon";

  @override
  String get goodEvening => "Good evening";

  @override
  String get motivationText => "Ready to crush your goals?";

  @override
  String get home => "Home";

  @override
  String get plans => "Plans";

  @override
  String get stats => "Stats";

  @override
  String get settings => "Settings";

  @override
  List<String> get weekDayNamesShort => <String>[
    "MON",
    "TUE",
    "WED",
    "THU",
    "FRI",
    "SAT",
    "SUN",
  ];

  @override
  List<String> get monthNames => <String>[
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    "december",
  ];

  @override
  String Function(DateTime) get formattedDate =>
      (DateTime date) =>
          '${weekDayNamesShort[date.weekday - 1].firstToUpperRestToLower()}. ${monthNames[date.month - 1]} ${date.day}';

  @override
  String Function(int, int) get workoutProgress =>
      (int progress, int goal) => '$progress of $goal workouts completed';

  @override
  String get exercises => "exercises";

  @override
  String get startWorkout => "Start workout";

  @override
  String get selectWorkout => "Select workout";

  @override
  String get allPlansHaveBeenCompleted => "All plans have been completed! 🔥";

  @override
  String get continueMessage =>
      "But if you are not satisfied you can continue...";

  // labels
  @override
  String get nextWorkout => "NEXT WORKOUT";

  @override
  String get thisWeek => "THIS WEEK";

  @override
  String get recentWorkouts => "RECENT WORKOUTS";

  @override
  String get yourPlans => "YOUR PLANS";

  @override
  String get created => "Created";

  @override
  String get areYouSureYouWantToDelete =>
      "Are you sure you want to delete workout plan with name";

  @override
  String get thisActionCannotBeUndone => "This action cannot be undone!";

  @override
  String get delete => "Delete";

  @override
  String get cancel => "Cancel";
}
