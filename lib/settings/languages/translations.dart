abstract class Translations {
  String get goodMorning;
  String get goodAfternoon;
  String get goodEvening;
  String get motivationText;
  String get home;
  String get plans;
  String get stats;
  String get settings;

  List<String> get weekDayNamesShort;
  List<String> get monthNames;
  String Function(DateTime) get formattedDate;

  String Function(int, int) get workoutProgress;
  String get exercises;
  String get startWorkout;
  String get selectWorkout;
  String get allPlansHaveBeenCompleted;
  String get continueMessage;

  // labels
  String get nextWorkout;
  String get thisWeek;
  String get recentWorkouts;

  String get yourPlans;
  String get created;

  String get areYouSureYouWantToDelete;
  String get thisActionCannotBeUndone;

  String get delete;
  String get cancel;

  String get weightUnit;
  String get reps;
  String get weight;

  String get areSureYouWantToExitWithoutSaving;
  String get areYouSureWantToUpdateThisWorkout;
  String get areYouSureYouWantToEnd;
  String get doYouWantToSaveChangesToYourPlan;

  String get yes;
  String get no;  
}
