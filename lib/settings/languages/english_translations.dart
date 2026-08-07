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
  String Function(int) get exercises =>
      (int exercisesNum) => switch (exercisesNum) {
        1 => "exercise",
        _ => "exercises",
      };

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
  String get activeWorkout => "ACTIVE WORKOUT";

  @override
  String get onlyOneSessionTitle =>
      "You can only have one active workout at a time";

  @override
  String Function(String) get onlyOneSessionDesc =>
      (String planName) =>
          'Finish $planName before starting a new workout session';

  @override
  String get created => "Created";

  @override
  String get areYouSureYouWantToDeletePlan =>
      "Are you sure you want to delete workout plan with name";

  @override
  String get areYouSureYouWantToDeleteLog =>
      "Are you sure you want to delete thus workout log?";

  @override
  String get thisActionCannotBeUndone => "This action cannot be undone!";

  @override
  String get delete => "Delete";

  @override
  String get edit => "Edit";

  @override
  String get cancel => "Cancel";

  @override
  String get weightUnit => "Weight unit";

  @override
  String get reps => "Reps";

  @override
  String get weight => "Weight";

  @override
  String get areSureYouWantToExitWithoutSaving =>
      "Are you sure you want leave without saving?";

  @override
  String get areYouSureWantToUpdateThisWorkout =>
      "Are sure you want to update this workout?";

  @override
  String get areYouSureYouWantToEnd => "Are sure you want to end this workout?";

  @override
  String get doYouWantToSaveChangesToYourPlan =>
      "Do you want to save changes to your plan?";

  @override
  String get yes => "Yes";

  @override
  String get no => "No";

  @override
  String get planCreator => "Plan creator";

  @override
  String get icon => "Icon";

  @override
  String get name => "Name";

  @override
  String get enterANameForYourWorkoutPlan =>
      "Enter a name for your workout plan";

  @override
  String get exercises2 => "Exercises";

  @override
  String get addExercise => "Add exercise";

  @override
  String get exerciseLibrary => "Exercise library";

  @override
  String get myExercises => "My exercises";

  @override
  String get searchExercise => "Search exercise...";

  @override
  String get exerciseCreator => "Exercise creator";

  @override
  String get exerciseName => "Exercise name";

  @override
  String get primaryMuscles => "Primary muscles";

  @override
  String get secondaryMuscles => "Secondary muscles";

  @override
  String get equipment => "Equipment";

  @override
  Map<String, Set<String>> get musclesCategorized => {
    // Chest
    'Chest': {'Chest', 'Upper Chest', 'Lower Chest'},

    // Back
    'Back': {'Lats', 'Upper Back', 'Middle Back', 'Lower Back', 'Traps'},

    // Shoulders
    'Shoulders': {'Front Delts', 'Side Delts', 'Rear Delts'},

    // Arms
    'Arms': {'Biceps', 'Triceps', 'Forearms', 'Brachialis', 'Brachioradialis'},

    // Core
    'Core': {'Abs', 'Obliques', 'Transverse Abdominis', 'Erector Spinae'},

    // Legs
    'Legs': {
      'Quadriceps',
      'Hamstrings',
      'Glutes',
      'Hip Flexors',
      'Adductors',
      'Abductors',
      'Calves',
      'Tibialis Anterior',
    },

    // Neck
    'Neck': {'Neck'},
  };

  @override
  Set<String> get equipmentSet => {
    'Barbell',
    'Dumbbells',
    'Kettlebell',

    'Cable',
    'Machine',
    'Smith Machine',

    'Bench',
    'Incline Bench',
    'Decline Bench',

    'Pull-Up Bar',
    'Dip Station',

    'EZ Bar',
    'Trap Bar',

    'Resistance Band',
    'Suspension Trainer',

    'Medicine Ball',
    'Swiss Ball',

    'Sled',
    'Landmine',

    'Bodyweight',

    'Other',

    'None',
  };

  @override
  String get progressOverview => "PROGRESS OVERVIEW";

  @override
  String get workouts => "Workouts";

  @override
  String get vsLastMonth => "vs last month";

  @override
  String get language => "LANGUAGE";

  @override
  String get timeIsUp => "Time is up!";

  @override
  String get save => "Save";

  @override
  String get saved => "Saved";

  @override
  String get weeklyTrainingGoal => "WEEKLY TRAINING GOAL";
  @override
  String get pleaseEnterACorrectNumber => "Please enter a valid number";
  @override
  String get weeklyGoalNumberMustBe => "Please enter a number between 0 and 7";

  @override
  String get workoutContinue => "Continue";
}
